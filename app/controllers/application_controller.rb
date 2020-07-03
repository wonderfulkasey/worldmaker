 class ApplicationController < ActionController::Base

    include UsersHelper
    # Logs in the given user
    def log_in(user)
      session[:user_id] = user.id
    end
  
    # Logs out the given user
    def log_out
      session.delete(:user_id)
      @current_user = nil
    end
  
    #Finds user, signs them up/logs them in
    def log_in_user_with_omniauth
      if auth
        user = User.find_or_create_by(uid: auth['uid']) do |u|
          u.username = auth['info']['name']
          u.email_address = auth['info']['email']
          u.password = SecureRandom.hex
        end
        user.password_confirmation = user.password
        user.save
        Contact.find_or_create_by(username: user.username)
        log_in(user)
        if user.groups.first
          redirect_to group_path(user.groups.first)
        else
          redirect_to users_path
        end
      else
        user = User.find_by(username: params[:session][:username])
        # method in application_controller
        redirect_user(user)
      end
    end
  
    # Signs up user and redirect to users path
    def signup_user(user)
      if user.save
        Contact.create(username: user.username)
        log_in user
        flash[:success] = "Welcome to Taut"
        redirect_to users_path
      else
        flash[:errors] = user.errors.full_messages
        redirect_to '/users/new'
      end
    end
  
    # Redirects user to home page or shows login errors
    def redirect_user(user)
      if user && user.authenticate(params[:session][:password])
        log_in user
        redirect_to group_path(user.groups.first)
      elsif user && !user.authenticate(params[:session][:password])
        flash[:notice] = 'Invalid password'
        redirect_to root_path
      else
        flash[:notice] = "Cannot find user. Make an account!"
        redirect_to new_user_path
      end
    end

    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
    helper_method :current_user
  
    def logged_in?
      if find_user.nil?
        redirect_to root_path
      end
    end
  
  
  end

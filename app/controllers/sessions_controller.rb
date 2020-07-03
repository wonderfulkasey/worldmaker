class SessionsController < ApplicationController

    layout 'login'
  
    def new
    end
  
    def create # receives data submitted in login form, authenticates and logs in a valid user
      if @user = User.find_or_create_from_auth_hash(auth_hash)
        session[:user_id] = @user.id
        redirect_to root_path  
      else
        @user = User.find_by(email: params[:email])
        if @user && @user.authenticate(params[:password])
          session[:user_id] = @user.id # log in the user
          redirect_to user_path(@user), flash: { success: "You successfully logged in! Welcome back to OCDefeat, #{@user.name}!" }
        else # present login form so user can try logging in again
          flash.now[:error] = "Your login attempt was unsuccessful. Please enter a valid email and password combination."
          render :new
        end
      end
    end
  
  
    def destroy
      # method in application_controller
      log_out
      redirect_to root_path
    end
  
    ####################### END ROUTES #####################
  
    private

    protected

    def auth_hash
      request.env['omniauth.auth']
    end
  
    def prevent_logged_in_users_from_viewing_login
      redirect_to root_path, alert: "You cannot view the login form since you're already logged in!" if current_user
    end
end

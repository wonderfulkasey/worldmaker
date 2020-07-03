class UsersController < ApplicationController
    before_action :logged_in?, only: [:index, :show]
   
    def index
      render layout: 'login'
    end
  
    def new
      @user = User.new
      render layout: 'login'
    end
  
    def create
      @user = User.new(user_params)
      if @user.save
        session[:user_id] = @user.id # log in the user
        redirect_to user_path(@user), flash: { success: "You successfully registered and created your preliminary profile, #{current_user.name}!" }
      else
        3.times { @user.treatments.build }
        flash.now[:error] = "Your registration attempt was unsuccessful. Please try again."
        render :new # present the registration form so the user can try signing up again
      end
  
    end
  
  
    ####################### END ROUTES #####################
  
    private
  
    def user_params
      params.require(:user).permit(:username, :email_address, :password, :password_confirmation)
    end
  
  
  end
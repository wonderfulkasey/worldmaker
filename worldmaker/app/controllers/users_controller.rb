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
      #method in application_controller
      signup_user(@user)
    end
  
  
    ####################### END ROUTES #####################
  
    private
  
    def user_params
      params.require(:user).permit(:username, :email_address, :password, :password_confirmation)
    end
  
  
  end
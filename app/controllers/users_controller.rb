class UsersController < ApplicationController
  # before_action :logged_in?, only: [:show]
  def new
    @user = User.new
  end

  def create
    # @use
  end

  def show
    #code
  end

  def login

  end

  def logout

  end

  def signup

  end

  private
    def user_params
        params.require(:user).permit(:first_name, :last_name, :email, :password)
    end

    def logged_in?
      redirect_to login_path unless current_user
    end

end

class UsersController < ApplicationController
  # before_action :logged_in?, only: [:show]
  before_action :set_and_booking_flights, only: [:show]
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
    user = User.from_omniauth(env['omniauth.auth'])
    session[:user_id] = user.id
    if env['omniauth.origin'].nil?
      redirect_to root_url
    else
      redirect_to env['omniauth.origin']
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to root_path
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

    def set_and_booking_flights
      @bookings = current_user.bookings
    end

end

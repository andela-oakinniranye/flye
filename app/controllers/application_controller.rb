class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]).decorate if session[:user_id]
  end

  def logged_in?
    unless current_user
      flash[:danger] = "You need to log in to perform this operation"
      redirect_to (request.referer || root_path)
    end
  end
end

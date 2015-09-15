class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user

  rescue_from ::ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ::NameError, with: :error_occurred
  rescue_from ::ActionController::RoutingError, with: :no_route_found
  rescue_from ::Exception, with: :error_occurred


  def no_route_found
    flash[:danger] = "You entered an invalid address!"
    redirect_to root_path
  end

private
  def record_not_found(exception)
    flash[:danger] = exception.message.to_s
    redirect_to root_path
  end


  def error_occurred(exception)
    flash[:danger] = exception.message.to_s
    redirect_to root_path
  end

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

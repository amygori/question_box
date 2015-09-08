class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery #with: :exception

  helper_method :current_user, :logged_in?

  add_flash_types :success, :info, :warning, :alert

  protected

  def current_user
    #return unless session[:user_id]
    @current_user ||= User.find_by_id(session[:current_user_id])
  end

  def logged_in?
    !!current_user
  end

  def authenticate
    redirect_to login_path, notice: "Please log in to continue" and return false unless logged_in?
  end
end


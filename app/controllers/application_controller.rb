class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def user_signed_in?
    if session[:ts_token]
      return true
    else
      return false
    end
  end

  def require_login
    unless session[:ts_token]
      redirect_to '/login'
    end
  end
end

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

  def ssl_configured?
    Rails.env.production?
  end

  # Setup TeamSnap client which is common for many controllers
  def set_ts_client
    @ts_client = TeamsnapClient.new(:auth_token => session[:ts_token])
  end

end

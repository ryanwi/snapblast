module ApplicationHelper

  def user_signed_in?
    if session[:ts_token]
      return true
    else
      return false
    end
  end

end

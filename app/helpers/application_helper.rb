module ApplicationHelper

  def user_signed_in?
    if session[:ts_token]
      return true
    else
      return false
    end
  end

  def analytics_events
    # flash[:events].inspect
    Array(flash[:events]).map do |event|
      "ga('send','event','#{event.join("','")}');"
    end.join("\n")
  end

end

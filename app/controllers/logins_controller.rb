class LoginsController < ApplicationController
  force_ssl if: :ssl_configured?

  # GET /logins/new
  # GET /logins/new.json
  def new
  end

  # POST /logins
  def create
    # sanity check
    if params[:user].blank? || params[:password].blank?
      flash.now[:alert] = 'Missing username or password'
      render action: 'new' and return
    end

    # Login with TeamSnap client
    ts_client = TeamsnapClient.new
    response = ts_client.get("authentication", headers:
      { "X-Teamsnap-User" => params[:user], "X-Teamsnap-Password" => params[:password] })

    if response.status == 204
      # Extract token from headers which will be used for subsequent requests
      token = response.headers["x-teamsnap-token"]
      session[:ts_token] = token

      # Publish event to track logins
      flash[:events] = [ ['login', 'success'] ]

      redirect_to '/teams', notice: 'Login was successful.'
    else
      # Publish event to track login failures
      flash.now[:events] = [ ['login', 'failed'] ]

      flash.now[:alert] = JSON.parse(response.body)["error"]
      render action: 'new'
    end
  end

  # DELETE /logins
  # DELETE /logins
  def destroy
    session[:ts_token] = nil
    flash[:notice] = "You have successfully logged out."
    redirect_to root_url
  end
end

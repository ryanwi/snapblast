class LoginsController < ApplicationController
  force_ssl if: :ssl_configured?

  # GET /logins
  # GET /logins.json
  def index
  end

  # GET /logins/new
  # GET /logins/new.json
  def new
  end

  # POST /logins
  # POST /logins.json
  def create
    ts_client = TeamsnapClient.new
    response = ts_client.get("authentication", headers:
      { "X-Teamsnap-User" => params[:user], "X-Teamsnap-Password" => params[:password] })

    respond_to do |format|
      if response.status == 204
        token = response.headers["x-teamsnap-token"]
        session[:ts_token] = token
        flash[:events] = [ ['login', 'success'] ]
        format.html { redirect_to '/teams', notice: 'Login was successful.' }
        # format.json { render action: 'show', status: :created, location: @user }
      else
        flash.now[:events] = [ ['login', 'failed'] ]
        flash.now[:alert] = JSON.parse(response.body)["error"]
        format.html { render action: 'new' }
        # format.json { render json: @user.errors, status: :unprocessable_entity }
      end
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

class LoginsController < ApplicationController

  # GET /logins
  # GET /logins.json
  def index
  end

  # POST /logins
  # POST /logins.json
  def create

  	ts_client = TeamsnapClient.new
  	response = ts_client.get("authentication", 
  		headers: { "X-Teamsnap-User" => params[:user], "X-Teamsnap-Password" => params[:password] })

    respond_to do |format|
      if response.status == 204
        token = response.headers["x-teamsnap-token"]
        session[:tstoken] = token
        format.html { redirect_to '/', notice: 'User was successfully created.' }
        # format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'index' }
        # format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
  end
end

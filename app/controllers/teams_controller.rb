class TeamsController < ApplicationController
  before_action :require_login

  # GET /teams
  # GET /teams.json
  def index
    # Get a list of teams for the user from the TeamSnap API
    ts_client = TeamsnapClient.new
    response = ts_client.get("teams", headers: { "X-Teamsnap-Token" => session[:ts_token] })
    @teams = JSON.parse response.body
  end

end

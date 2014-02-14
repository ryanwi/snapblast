class TeamsController < ApplicationController
  before_action :require_login

  # GET /teams
  # GET /teams.json
  def index
    ts_client = TeamsnapClient.new
    response = ts_client.get("teams", headers:
      { "X-Teamsnap-Token" => session[:ts_token] })
    @teams = JSON.parse response.body
  end

  # GET /teams/1
  # GET /teams/1.json
  def show
    ts_client = TeamsnapClient.new

    # Get Team information
    team_response = ts_client.get("teams/#{params[:id]}", headers:
      { "X-Teamsnap-Token" => session[:ts_token] })
    @team = JSON.parse team_response.body

    # Get Roster information
    roster_response = ts_client.get("teams/#{params[:id]}/as_roster", headers:
      { "X-Teamsnap-Token" => session[:ts_token] })
    @roster = JSON.parse roster_response.body
  end

end

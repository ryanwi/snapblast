class TeamsController < ApplicationController
  before_action :require_login

  # GET /teams
  # GET /teams.json
  def index
    # Get a list of teams for the user from the TeamSnap API
    # cache response and scope it to the user's session
    ts_client = TeamsnapClient.new
    teams_resource = "teams"
    teams_key = "#{session[:ts_token]}_#{teams_resource}"
    @teams = Rails.cache.fetch teams_key, :expires_in => 1.minute do
      response = ts_client.get(teams_resource,
        headers: { "X-Teamsnap-Token" => session[:ts_token] })
      JSON.parse response.body
    end
  end

end

class TeamsController < ApplicationController
  before_action :require_login
  before_action :set_ts_client

  # GET /teams
  # GET /teams.json
  def index
    # Get a list of teams for the user from the TeamSnap API
    @teams = @ts_client.teams
  end

end

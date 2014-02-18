class TeamsnapClient

  # Initializes a new TeamSanp client
  def initialize(options = {})
    # Set auth token for most requests (all but authentication)
    headers = {}
    @auth_token = options[:auth_token]
    headers["X-Teamsnap-Token"] = @auth_token unless @auth_token.blank?

    @conn = Faraday.new(url: 'https://api.teamsnap.com', headers: headers ) do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end
  end

  # Send a GET a request
  #
  # @param resource
  #   The API resource to access
  #
  def get(resource, options={})
    response = @conn.get do |req|
      req.url "/v2/#{resource}"
      req.headers.merge!(options[:headers]) unless options[:headers].nil?
      req.params.merge!(options[:params]) unless options[:params].nil?
    end

    response
  end

  # Send a POST a request
  #
  # @param resource
  #   The API resource to access
  #
  def post(resource, options={})
    response = @conn.post do |req|
      req.url "/v2/#{resource}"
      req.headers.merge!(options[:headers]) unless options[:headers].nil?
      req.params.merge!(options[:params]) unless options[:params].nil?
    end

    response
  end

  # List available teams for the user
  #
  def teams
    teams_resource = "teams"
    teams_key = "#{@auth_token}_#{teams_resource}"
    teams = Rails.cache.fetch teams_key, :expires_in => 10.minutes do
      response = get teams_resource
      JSON.parse response.body
    end
  end

  # Get a user's team
  #
  def team(team_id)
    team_resource = "teams/#{team_id}"
    team_key = "#{@auth_token}_#{team_resource}"
    team = Rails.cache.fetch team_key, :expires_in => 10.minutes do
      team_response = get team_resource
      JSON.parse team_response.body
    end
  end

  # Get list of rosters available for the user on the team
  #
  def as_rosters(team_id)
    as_roster_resource = "teams/#{team_id}/as_roster"
    as_roster_key = "#{@auth_token}_#{as_roster_resource}"
    as_roster = Rails.cache.fetch as_roster_key, :expires_in => 10.minutes do
      as_roster_response = get as_roster_resource
      JSON.parse as_roster_response.body
    end
  end

  # Get Complete Roster information for the team
  #
  def team_rosters(team_id, as_roster_id)
    team_rosters_resource = "teams/#{team_id}/as_roster/#{as_roster_id}/rosters"
    team_rosters_key = "#{@auth_token}_#{team_rosters_resource}"
    team_rosters = Rails.cache.fetch team_rosters_key, :expires_in => 10.minutes do
      team_rosters_response = get team_rosters_resource
      JSON.parse team_rosters_response.body
    end
  end

end

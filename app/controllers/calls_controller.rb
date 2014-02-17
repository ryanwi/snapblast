require 'uri'

class CallsController < ApplicationController
  before_action :require_login
  before_action :set_ts_client

  def new
    @team_id = params[:id]

    # Get Team information
    # cache team response and scope it to the user's session
    team_resource = "teams/#{@team_id}"
    team_key = "#{session[:ts_token]}_#{team_resource}"
    @team = Rails.cache.fetch team_key, :expires_in => 10.minutes do
      team_response = @ts_client.get(team_resource,
        headers: { "X-Teamsnap-Token" => session[:ts_token] })
      JSON.parse team_response.body
    end

    # Determine roster_id to use
    # cache response scoped to the user's session
    as_roster_resource = "teams/#{@team_id}/as_roster"
    as_roster_key = "#{session[:ts_token]}_#{as_roster_resource}"
    @as_roster = Rails.cache.fetch as_roster_key, :expires_in => 10.minutes do
      as_roster_response = @ts_client.get(as_roster_resource,
        headers: { "X-Teamsnap-Token" => session[:ts_token] })
      JSON.parse as_roster_response.body
    end

    # Just taking first for now, may need to prompt or be smarter about picking
    @roster_id = @as_roster.first['roster']['id']
    @team_rosters = get_team_rosters(@team_id, @roster_id)
  end

  def create
    team_id = params[:team_id]
    roster_id = params[:roster_id]

    # collect phone numbers from team roster
    @team_rosters = get_team_rosters(team_id, roster_id)
    phone_numbers = []
    @team_rosters.each do |roster|
      roster["roster"]["roster_telephone_numbers"].each do |phone|
        phone_numbers << phone["phone_number"] unless phone["phone_number"].nil?
      end
      roster["contacts"].each do |contact|
        contact["contact_telephone_numbers"].each do |phone|
          phone_numbers << phone["phone_number"] unless phone["phone_number"].blank?
        end
      end
    end

    # Build message
    message = URI.escape params[:message]

    # Make the calls
    # TODO: queue calls with Resque/DelayedJob
    # TODO: log the calls to the database
    twilio = Twilio::REST::Client.new ENV["TWILIO_ACCOUNT_SID"], ENV["TWILIO_AUTH_TOKEN"]
    phone_numbers.each do |phone_number|
      begin
        puts "==================== calling"
        puts "#{phone_number}"
        call = twilio.account.calls.create({
          :from => ENV["TWILIO_FROM"],
          :to => phone_number,
          :url => "http://twimlets.com/message?Message%5B0%5D=#{message}"
          # :status_callback => "http://requestb.in/11k3d6m1"
        })
      rescue Twilio::REST::RequestError => e
        puts "==================== error"
        puts e.message
      end
    end

    flash[:events] = [ ['call'] ]
    redirect_to "/teams", notice: "Your calls have been made"
  end

  private

    # Setup TeamSnap client which is common for all actions
    def set_ts_client
      @ts_client = TeamsnapClient.new
    end

    # Get Complete Roster information for the team
    def get_team_rosters(team_id, as_roster_id)
      # cache roster response and scope it to the user's session
      team_rosters_resource = "teams/#{team_id}/as_roster/#{as_roster_id}/rosters"
      team_rosters_key = "#{session[:ts_token]}_#{team_rosters_resource}"
      team_rosters = Rails.cache.fetch team_rosters_key, :expires_in => 10.minutes do
        team_rosters_response = @ts_client.get(team_rosters_resource,
          headers: { "X-Teamsnap-Token" => session[:ts_token] })
        JSON.parse team_rosters_response.body
      end
    end

end

require 'uri'

class CallsController < ApplicationController
  before_action :require_login
  before_action :set_ts_client

  def new
    @team_id = params[:id]

    # Get Team information
    @team = @ts_client.team(@team_id)

    # Determine roster_id to use
    # Just taking first for now, may need to prompt or be smarter about picking
    as_rosters = @ts_client.as_rosters(@team_id)
    @roster_id = as_rosters.first['roster']['id']

    @team_rosters = @ts_client.team_rosters(@team_id, @roster_id)
  end

  def create
    team_id = params[:team_id]
    roster_id = params[:roster_id]

    # collect phone numbers from team
    team_rosters = @ts_client.team_rosters(team_id, roster_id)
    phone_numbers = TeamPhoneNumberCollector.collect(team_rosters)

    # Build message
    message = URI.escape params[:message]

    # Make the calls
    # TODO: queue calls with Resque/DelayedJob/sikekiq
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

end

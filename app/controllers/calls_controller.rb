class CallsController < ApplicationController
  before_action :require_login

  def new
    ts_client = TeamsnapClient.new

    # Get Team information
    # store team response in cache and scope it to the user
    team_cache_key = "#{session[:ts_token]}_team_#{params[:id]}"
    @team = Rails.cache.fetch team_cache_key, :expires_in => 1.hour do
      team_response = ts_client.get("teams/#{params[:id]}", headers:
        { "X-Teamsnap-Token" => session[:ts_token] })
      JSON.parse team_response.body
    end

    # Get Roster information
    # store roster response in cache and scope it to the user
    roster_cache_key = "#{session[:ts_token]}_roster_#{params[:id]}"
    @roster = Rails.cache.fetch roster_cache_key, :expires_in => 1.hour do
      roster_response = ts_client.get("teams/#{params[:id]}/as_roster", headers:
        { "X-Teamsnap-Token" => session[:ts_token] })
      JSON.parse roster_response.body
    end
  end

  def create
    # collect phone numbers from roster, which should be cached
    roster_cache_key = "#{session[:ts_token]}_roster_#{params[:team_id]}"
    @roster = Rails.cache.fetch roster_cache_key, :expires_in => 1.hour do
      roster_response = ts_client.get("teams/#{params[:id]}/as_roster", headers:
        { "X-Teamsnap-Token" => session[:team_id] })
      JSON.parse roster_response.body
    end

    phone_numbers = []
    @roster.each do |roster|
      roster["roster"]["roster_telephone_numbers"].each do |phone|
        phone_numbers << phone["phone_number"]
      end
    end

    STDERR.puts phone_numbers.inspect


    # flash
    redirect_to "/teams"
  end
end

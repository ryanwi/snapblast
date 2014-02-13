class TeamsnapClient

  #
  def initialize(options = {})
    @conn = Faraday.new(:url => 'https://api.teamsnap.com') do |faraday|
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

end

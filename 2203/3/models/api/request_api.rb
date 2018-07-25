require 'net/https'
require 'uri'
require 'json'

# Class send request to Azure API
class RequestApi
  attr_reader :uri, :request

  ACCESS_KEY = 'paste_your_key'.freeze

  def initialize(data)
    @uri = URI('https://westeurope.api.cognitive.microsoft.com/text/analytics/v2.0/sentiment')
    @request = create_request(data)
  end

  def create_request(data)
    request = Net::HTTP::Post.new(uri)
    request['Content-Type'] = 'application/json'
    request['Ocp-Apim-Subscription-Key'] = ACCESS_KEY
    request.body = data.to_json
    request
  end

  def request_respond
    Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
      http.request(request)
    end
  end
end

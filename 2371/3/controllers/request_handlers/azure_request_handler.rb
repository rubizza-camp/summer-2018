require 'net/https'
require 'uri'
require 'json'
require_relative 'request_handler'
# The AzureRequestHandler responsible for make request on Azure api
class AzureRequestHandler < RequestHandler
  def make_request(data_handler)
    uri = URI(args[:uri] + args[:path])
    res = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
      http.request(create_request(uri))
    end
    data_handler.handle_data(res.body)
  end

  def create_request(uri)
    request = Net::HTTP::Post.new(uri)
    request['Content-Type'] = "application/json"
    request['Ocp-Apim-Subscription-Key'] = args[:api_key]
    request.body = args[:document].to_json
    request
  end
end
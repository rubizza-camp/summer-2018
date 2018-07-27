require 'net/https'
require 'uri'
require 'json'
require_relative 'request_handler'
# The OnlinerRequestHandler responsible for making request on onliner
class OnlinerRequestHandler < RequestHandler
  def make_request(data_handler)
    res = Net::HTTP.get_response(URI(args[:url]))
    data_handler.handle_data(res.body) if res.is_a?(Net::HTTPSuccess)
  end
end
require 'net/https'
require 'uri'
require 'json'
# :reek:FeatureEnvy
# :reek:TooManyStatements
class Analytics
  attr_reader :text

  def initialize(text)
    @text = text
  end

  def run
    access_key = SECRET_KEY.freeze

    uri = 'https://westcentralus.api.cognitive.microsoft.com'
    path = '/text/analytics/v2.0/sentiment'

    uri = URI(uri + path)

    documents = { 'documents' => [{ 'id': '1', 'language': 'ru', 'text': text }] }
    request = Net::HTTP::Post.new(uri)
    request['Content-Type'] = 'application/json'
    request['Ocp-Apim-Subscription-Key'] = access_key
    request.body = documents.to_json

    response = Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
      http.request(request)
    end

    information = JSON.pretty_generate(JSON(response.body))
    information = information.gsub(/^\s+|\n|\r|\s+$|\D/, ' ').split
    (information[0] + '.' + information[1]).to_f
  end
end

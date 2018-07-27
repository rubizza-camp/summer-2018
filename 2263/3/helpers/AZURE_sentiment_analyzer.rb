require 'net/https'
require 'uri'
require 'json'

# Class, that performs requests to AZURE sentiment analyzing API
class AZURESentimentAnalyzer
  def initialize(access_key)
    @access_key = access_key
    @uri = URI('https://westeurope.api.cognitive.microsoft.com/text/analytics/v2.0/sentiment')
  end

  def analyze(comment)
    request = form_request(comment)
    response = send_request(request)
    sentiment(response)
  end

  private

  def form_request(comment)
    request = Net::HTTP::Post.new(@uri)
    request['Content-Type'] = 'application/json'
    request['Ocp-Apim-Subscription-Key'] = @access_key
    request.body = { 'documents': [{ 'id' => '1', 'text' => comment }] }.to_json
    request
  end

  def send_request(request)
    response = Net::HTTP.start(@uri.host, @uri.port, use_ssl: @uri.scheme == 'https') do |http|
      http.request(request)
    end
    JSON::pretty_generate(JSON(response.body))
  end

  def sentiment(response)
    response_hash = JSON.parse(response)
    response_hash['documents'][0]['score']
  end
end

require 'net/https'
require 'uri'
require 'json'

# Class, that performs requests to AZURE sentiment analyzing API
class AZURESentimentAnalyzer
  def initialize(access_key)
    @access_key = access_key
    @uri = URI('https://westeurope.api.cognitive.microsoft.com/text/analytics/v2.0/sentiment')
  end

  def analyze(comments)
    request = form_request(comments)
    response = send_request(request)
    sentiment_list(response)
  end

  private

  def form_request(comments)
    request = Net::HTTP::Post.new(@uri)
    request['Content-Type'] = 'application/json'
    request['Ocp-Apim-Subscription-Key'] = @access_key
    request.body = form_request_body(comments)
    request
  end

  def form_request_body(comments)
    counter = 0
    comments.each_with_object({ 'documents': [] }) do |comment, body|
      body[:documents] << { 'id' => counter += 1, 'text' => comment}
    end.to_json
  end

  def send_request(request)
    response = Net::HTTP.start(@uri.host, @uri.port, use_ssl: @uri.scheme == 'https') do |http|
      http.request(request)
    end
    JSON.pretty_generate(JSON(response.body))
  end

  def sentiment_list(response)
    response_hash = JSON.parse(response)
    response_hash['documents'].each_with_object([]) { |info, sentiment_list| sentiment_list << info['score']}
  end
end

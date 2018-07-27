require 'uri'
require 'net/https'

module SentimentParser
  ACCESS_KEY = '***'.freeze
  URL = URI('https://westcentralus.api.cognitive.microsoft.com/text/analytics/v2.0/sentiment')

  def create_sentiments(comments)
    response = Net::HTTP.start(URL.host, URL.port, use_ssl: URL.scheme == 'https') do |http|
      http.request(create_request(comments))
    end
    JSON(response.body)['documents']
  end

  private

  def create_request(comments)
    request = Net::HTTP::Post.new(URL, 'Content-Type' => 'application/json', 'Ocp-Apim-Subscription-Key' => ACCESS_KEY)
    request.body = documents(comments)
    request
  end

  def documents(comments)
    texts = comments.map do |author, text|
      { 'id' => author, 'language' => 'ru', 'text' => text }
    end
    { 'documents' => texts }.to_json
  end
end

require 'uri'
require 'json'
require 'net/https'

class TextChecker
  ACCESS_KEY = 'c2b502fd9bf046c0ac3820967368c382'.freeze
  LINK = 'https://westcentralus.api.cognitive.microsoft.com/text/analytics/v2.0/sentiment'.freeze
  URL = URI(LINK)
  def initialize(texts)
    @texts = texts
  end

  def check
    JSON.parse(response.body)['documents'].map { |text| (text['score'].round(2) * 200 - 100).to_i }
  end

  private

  def response
    Net::HTTP.start(URL.host, URL.port, use_ssl: URL.scheme == 'https') do |http|
      http.request(request_preparation)
    end
  end

  def request_preparation
    request = Net::HTTP::Post.new(URL, 'Content-Type' => 'application/json', 'Ocp-Apim-Subscription-Key' => ACCESS_KEY)
    request.body = document.to_json
    request
  end

  def document
    { 'documents': @texts.map.with_index { |text, index| { 'id' => index.to_s, 'language' => 'ru', 'text' => text } } }
  end
end

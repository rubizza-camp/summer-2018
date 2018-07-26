require 'uri'
require 'json'
require 'faraday'

class TextChecker
  ACCESS_KEY = '47faf0afe2b04cf281f861ba8856901a'.freeze
  LINK = 'https://westcentralus.api.cognitive.microsoft.com/text/analytics/v2.0/sentiment'.freeze
  def initialize(texts)
    @texts = texts
  end

  def check
    JSON.parse(response.body)['documents'].map { |text| (text['score'].round(2) * 200 - 100).to_i }
  end

  private

  def response
    Faraday.new.post do |request|
      request.url LINK
      request.headers['Content-Type'] = 'application/json'
      request.headers['Ocp-Apim-Subscription-Key'] = ACCESS_KEY
      request.body = document.to_json
    end
  end

  def document
    { 'documents': @texts.map.with_index { |text, index| { 'id' => index.to_s, 'language' => 'ru', 'text' => text } } }
  end
end

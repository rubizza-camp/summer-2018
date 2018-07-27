require 'faraday'
require 'pry'

class Azure
  URI = 'https://westcentralus.api.cognitive.microsoft.com'.freeze
  PATH = '/text/analytics/v2.0/sentiment'.freeze

  attr_reader :texts

  def initialize(texts)
    @texts = texts
  end

  def texts_evaluation
    [texts, evaluations].transpose.to_h
  end

  private

  def evaluations
    JSON.parse(response.body)['documents'].map do |document|
      (document['score'] * 100).round
    end
  end

  def connection
    @connection ||= Faraday.new(URI)
  end

  def response
    headers = { 'Content-Type' => 'application/json',
                'Ocp-Apim-Subscription-Key' => File.read('settings/azure_key.txt') }
    connection.post do |request|
      request.url PATH
      request.headers headers
      request.body = { documents: documents }.to_json
    end
  end

  def documents
    texts.map.with_index(1) do |text, index|
      {
        id: index,
        language: 'ru',
        text: text
      }
    end
  end
end

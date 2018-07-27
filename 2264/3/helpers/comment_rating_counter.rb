require 'net/https'
require 'uri'
require 'json'

# Rating Counter
class CommentRatingCounter
  URL = 'https://westcentralus.api.cognitive.microsoft.com'.freeze
  PATH = '/text/analytics/v2.0/sentiment'.freeze
  KEY = 'de8a560ccae541e08ec1a30dcdd191a4'.freeze

  attr_reader :uri, :documents, :request

  def initialize(texts)
    @uri = URI(URL + PATH)
    build_documents(texts)
  end

  def launch_counter
    build_answer
  end

  private

  def build_documents(text_body)
    @documents = { documents: [] }
    text_body.each_with_index do |text, index|
      documents[:documents].push('id' => index.to_s, 'language' => 'ru', 'text' => text)
    end
  end

  def build_answer
    JSON.parse(build_response.body)['documents'].map do |document|
      (document['score'] * 200).to_i - 100
    end
  end

  def build_response
    build_request
    Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
      http.request(request)
    end
  end

  def build_request
    @request = Net::HTTP::Post.new(uri)
    request['Content-Type'] = 'application/json'
    request['Ocp-Apim-Subscription-Key'] = KEY
    request.body = documents.to_json
  end
end
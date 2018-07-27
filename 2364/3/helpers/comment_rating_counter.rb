require 'net/https'
require 'uri'
require 'json'

# Counts rating of comments
class CommentRatingCounter
  ACESS_KEY = 'sfdfds'.freeze
  URI = 'https://westcentralus.api.cognitive.microsoft.com'.freeze
  PATH = '/text/analytics/v2.0/sentiment'.freeze

  attr_reader :uri, :documents, :request

  def initialize(texts)
    @uri = URI(URI + PATH)
    create_documents(texts)
  end

  def run
    create_answer
  end

  private

  def create_answer
    response = create_response
    counting_score = ->(document) { (document['score'] * 200).to_i - 100 }
    JSON.parse(response.body)['documents'].map(&counting_score)
  end

  def create_response
    create_request
    Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
      http.request(request)
    end
  end

  def create_documents(texts)
    @documents = { documents: [] }
    texts.each_with_index do |text, index|
      documents[:documents] << { 'id' => index.to_s, 'language' => 'ru', 'text' => text }
    end
  end

  def create_request
    @request = Net::HTTP::Post.new(uri)
    request['Content-Type'] = 'application/json'
    access_key = YAML.load_file(File.join(Dir.pwd, 'keys.yml'))['access_key']
    request['Ocp-Apim-Subscription-Key'] = access_key
    request.body = documents.to_json
  end
end

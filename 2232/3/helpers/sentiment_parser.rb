require 'uri'
require 'net/https'

class SentimentParser
  ACCESS_KEY = YAML.load_file(File.join(Dir.pwd, 'config.yml'))['access_key']
  URL = URI('https://westcentralus.api.cognitive.microsoft.com/text/analytics/v2.0/sentiment')

  def initialize(comments)
    @comments = comments
  end

  def call
    response = Faraday.new.post(URL) do |req|
      req = header(req)
      req.body = documents
    end
    JSON(response.body)['documents']
  end

  private

  def header(req)
    req.headers['Content-Type'] = 'application/json'
    req.headers['Ocp-Apim-Subscription-Key'] = ACCESS_KEY
    req
  end

  def documents
    texts = @comments.map.with_index do |comment, index|
      { 'id' => index, 'language' => 'ru', 'text' => comment[1] }
    end
    { 'documents' => texts }.to_json
  end
end

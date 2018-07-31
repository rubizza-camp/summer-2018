require 'net/https'
require 'uri'
require 'json'
# Analysis via Azure API
class TextAnalytics
  def initialize
    @uri = URI('https://westeurope.api.cognitive.microsoft.com/text/analytics/v2.0/sentiment')
  end

  def analyse(comment)
    response = Net::HTTP.start(@uri.host, @uri.port, use_ssl: @uri.scheme == 'https') do |http|
      http.request request(comment)
    end
    comment.update score: convert((JSON response.body)['documents'][0]['score'])
  end

  def convert(value)
    proportion = 1 / value
    200 / proportion - 100
  end

  private

  def access_key
    @access_key = YAML.load_file(File.join(Dir.pwd, 'config.yml'))['access_key']
  end

  def documents(comment)
    { 'documents': [{ 'id': '1', 'language': 'ru', 'text': comment.comment.to_s }] }
  end

  def request(comment)
    request = Net::HTTP::Post.new(@uri)
    request['Content-Type'] = 'application/json'
    request['Ocp-Apim-Subscription-Key'] = access_key
    request.body = documents(comment).to_json
    request
  end
end

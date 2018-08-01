require 'net/https'
require 'uri'
require 'json'
require_relative 'converter'
# Analysis via Azure API
class TextAnalytics
  def initialize
    @uri = URI('https://westeurope.api.cognitive.microsoft.com/text/analytics/v2.0/sentiment')
  end

  def analyse(comment)
    response = Net::HTTP.start(@uri.host, @uri.port, use_ssl: @uri.scheme == 'https') do |http|
      http.request request(comment)
    end
    update_comment(comment, response)
  end

  private

  def access_key
    @access_key = YAML.load_file(File.join(Dir.pwd, 'config.yml'))['access_key']
  end

  def documents(comment)
    documents = {}
    documents['documents'] = [{ 'id' => '1', 'language' => 'ru', 'text' => comment.comment.to_s }]
    documents
  end

  def update_comment(comment, response)
    comment.update score: Converter.new(((JSON response.body)['documents'][0]['score'])).final_value
  end

  def request(comment)
    request = Net::HTTP::Post.new(@uri)
    request['Content-Type'] = 'application/json'
    request['Ocp-Apim-Subscription-Key'] = access_key
    request.body = documents(comment).to_json
    request
  end
end

# rubocop:disable Style/UnneededInterpolation
require 'net/https'
require 'uri'
require 'json'
# Analysis via Azure API
class TextAnalytics
  def analyse(comment)
    uri = 'https://westeurope.api.cognitive.microsoft.com'
    path = '/text/analytics/v2.0/sentiment'
    uri = URI(uri + path)

    documents = { 'documents': [{ 'id' => '1', 'language' => 'ru', 'text' => "#{comment.comment}" }] }

    request = Net::HTTP::Post.new(uri)
    request['Content-Type'] = 'application/json'
    access_key = YAML.load_file(File.join(Dir.pwd, 'config.yml'))['access_key']
    request['Ocp-Apim-Subscription-Key'] = access_key
    
    request.body = documents.to_json

    response = Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
      http.request request
    end
    comment.update score: convert((JSON response.body)['documents'][0]['score'])
  end

  def convert(value)
    x = 1 / value
    200 / x - 100
  end
end
# rubocop:enable Style/UnneededInterpolation

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
    request['Ocp-Apim-Subscription-Key'] = access_key
    request.body = documents.to_json
    response = Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
      http.request request
    end
    @value = (JSON response.body)['documents'][0]['score']
    comment.update score: convert
  end

  def convert
    proportion = 1 / @value
    200 / proportion - 100
  end

  def access_key
    @access_key = YAML.load_file(File.join(Dir.pwd, 'config.yml'))['access_key']
  end
end

require 'net/https'
require 'uri'
require 'json'
require './helpers/setting'
# This is class conects to API AZURE, Analyze sentiment texts and
# fetch score for his
class RatingCounter
  KEY_AZURE = Setting.get('key_azure').freeze
  URI_BASE  = 'https://westcentralus.api.cognitive.microsoft.com/text/analytics/v2.0/sentiment'.freeze
  PATH      = URI(URI_BASE).freeze
  attr_reader :data, :request

  def initialize
    @data = { documents: [] }
  end

  def perform(comments)
    handling_data(comments)
    @request = prepare_request
    output_data(send_request)
  end

  private

  def handling_data(comments)
    comments.each_with_index do |comment, index|
      @data[:documents] << { 'id' => index.to_s, 'language' => 'ru',
                             'text' => comment }
    end
  end

  def send_request
    Net::HTTP.start(PATH.host, PATH.port,
                    use_ssl: PATH.scheme == 'https') do |http|
      http.request(request)
    end
  end

  def output_data(response)
    body = response.body
    JSON.parse(body)['documents'].each_with_object([]) do |data, rating|
      rating << ((data['score'] * 200).to_i - 100)
    end
  end

  def headers
    heads = {}
    heads['Content-Type'] = 'application/json'
    heads['Ocp-Apim-Subscription-Key'] = KEY_AZURE
    heads
  end

  def prepare_request
    request = Net::HTTP::Post.new(PATH, headers)
    request.body = data.to_json
    request
  end
end

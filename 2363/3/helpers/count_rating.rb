# frozen_string_literal: true

require 'net/https'
require 'uri'
require 'json'

# This class get array of comments and return rating for every comment
class CountRating
  ACESS_KEY = env['ACCESS_KEY']
  URI = 'https://westcentralus.api.cognitive.microsoft.com'
  PATH = '/text/analytics/v2.0/sentiment'
  attr_reader :data, :uri, :request

  def initialize
    @uri = URI(URI + PATH)
    @data = { 'documents': [] }
  end

  def run(comments)
    prepare_data(comments)
    prepare_request
    prepare_output_data(send_request)
  end

  private

  def prepare_data(comments)
    comments.zip((0...comments.size)).each do |comment|
      @data[:documents] << { 'id' => comment.last.to_s, 'language' => 'ru', 'text' => comment.first }
    end
  end

  def send_request
    Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
      http.request(request)
    end
  end

  def prepare_output_data(response)
    JSON.parse(response.body)['documents'].each_with_object([]) do |data, rating|
      rating << ((data['score'] * 200).to_i - 100)
    end
  end

  # prepare data fro api
  def prepare_request
    @request = Net::HTTP::Post.new(uri)
    @request['Content-Type'] = 'application/json'
    @request['Ocp-Apim-Subscription-Key'] = ACESS_KEY
    @request.body = data.to_json
  end
end

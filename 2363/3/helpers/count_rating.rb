# frozen_string_literal: true

require 'net/https'
require 'uri'
require 'json'

# Instance use the most time in prepare request because
# This class get array of comments and return rating for every comment
class CountRating
  URI = 'https://westcentralus.api.cognitive.microsoft.com'.freeze
  PATH = '/text/analytics/v2.0/sentiment'.freeze
  attr_reader :data, :uri, :request

  def initialize(comments, api_key)
    @uri = URI(URI + PATH)
    @data = { documents: [] }
    prepare_data(comments)
    @request = prepare_request(api_key)
  end

  def run
    prepare_output_data(send_request)
  end

  private

  def prepare_data(comments)
    comments.each_with_index do |comment, index|
      @data[:documents] << { 'id' => index.to_s, 'language' => 'ru', 'text' => comment }
    end
  end

  def send_request
    Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
      http.request(request)
    end
  end

  def prepare_output_data(response)
    JSON.parse(response.body)['documents'].map do |data|
      ((data['score'] * 200).to_i - 100)
    end
  end

  # prepare data fro api
  def prepare_request(api_key)
    request = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json', 'Ocp-Apim-Subscription-Key' => api_key)
    request.body = data.to_json
    request
  end
end

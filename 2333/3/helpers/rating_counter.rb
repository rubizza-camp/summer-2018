# frozen_string_literal: true

require 'json'
require 'uri'
require 'net/http'

# the class that send request to Azure and get comments rating
class RatingCounter
  URI = 'https://westeurope.api.cognitive.microsoft.com/text/analytics/v2.0/sentiment'
  KEY = YAML.load_file('config.yml')['KEY']
  attr_reader :request, :uri
  def initialize(comments)
    @uri = URI(URI)
    @data = { documents: [] }
    @comments = comments
    @request = create_post_request(KEY)
  end

  def rating
    JSON.parse(send_request.body)['documents'].map { |data| (data['score'] * 200).to_i - 100 }
  end

  private

  def send_request
    Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
      http.request(request)
    end
  end

  def prepare_data_for_request
    @comments.each_with_index do |comment, index|
      @data[:documents] << { id: index.to_s, language: 'ru', text: comment }
    end
  end

  def create_post_request(access_key)
    prepare_data_for_request
    request = Net::HTTP::Post.new(uri,
                                  'Content-Type' => 'application/json',
                                  'Ocp-Apim-Subscription-Key' => access_key)
    request.body = @data.to_json
    request
  end
end

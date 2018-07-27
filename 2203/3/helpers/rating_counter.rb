require 'net/https'
require 'uri'
require 'json'

# Prepare and send request to get comment rating
class RatingCounter
  attr_reader :request

  URI = 'https://westcentralus.api.cognitive.microsoft.com/text/analytics/v2.0/sentiment'.freeze
  ACCESS_KEY = 'aa849bb0aa8a4045a5a1ccf4e668fa00'.freeze

  def initialize(comments)
    @uri = URI(URI)
    @data = { documents: [] }
    @comments = comments
  end

  def calculate
    prepare_comments
    @request = create_request
    response = send_request
    JSON.parse(response.body)['documents'].map { |data| (data['score'] * 200).to_i - 100 }
  end

  private

  def send_request
    Net::HTTP.start(@uri.host, @uri.port, use_ssl: @uri.scheme == 'https') do |http|
      http.request(request)
    end
  end

  def prepare_comments
    @comments.each_with_index do |comment, index|
      @data[:documents] << { 'id' => index.to_s, 'language' => 'ru', 'text' => comment[:text] }
    end
  end

  def create_request
    request = Net::HTTP::Post.new(@uri, 'Content-Type' => 'application/json',
                                        'Ocp-Apim-Subscription-Key' => ACCESS_KEY)
    request.body = @data.to_json
    request
  end
end

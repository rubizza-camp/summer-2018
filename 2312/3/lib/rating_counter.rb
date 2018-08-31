require 'net/https'
require 'uri'
require 'json'

# this class returns all ratings of provided comments
class RatingCounter
  attr_reader :request, :uri, :data, :comments

  def initialize(sorted_comments)
    @comments = sorted_comments
    @data = data_for_request
    @request = RequestGenerator.new(data)
  end

  def comments_ratings
    response = request.response
    JSON.parse(response.body)['documents'].map { |data| (data['score'] * 200).to_i - 100 }
  end

  private

  def data_for_request
    data = { documents: [] }
    comments.each_with_index do |comment, index|
      data[:documents] << { 'id' => index.to_s, 'language' => 'ru', 'text' => comment[:text] }
    end
    data
  end
end

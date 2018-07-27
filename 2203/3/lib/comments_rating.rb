require './api/text_analytics.rb'
require './comments_reader.rb'

# This class add rating to each comment
class CommentsRating
  attr_reader :response_from_azure, :api_rating, :comments_rating, :rating, :comments_array

  def initialize(response_from_azure, comments_array)
    @api_rating = response_from_azure['documents']
    @comments_array  = comments_array
    @comments_rating = {}
    calculate_comments_ratings
    @rating = { post_rating: post_rating,
                comments_ratings: comments_rating,
                comments_id: comments_ids }
  end

  private

  def post_rating
    rating = 0
    comments_rating.each { |_comment, coments_rating| rating += coments_rating }
    (rating / comments_rating.size).to_i
  end

  def calculate_comments_ratings
    api_rating.each do |comment|
      id = comment['id'].to_i
      comments_rating[id.to_i] = (comment['score'] * 200 - 100).to_i
    end
  end

  def comments_ids
    (0...api_rating.size).each_with_object({}) { |id, hash| hash[id] = comments_array[id] }
  end
end

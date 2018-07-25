require './api/text_analytics.rb'
require './comments.rb'

# This class add rating to each comment
class CommentsRating
  attr_reader :comments, :api_rating, :comments_rating, :rating

  def initialize(link)
    @comments   = Comments.new(link).comments_list
    @api_rating = TextAnalytic.new(comments).json['documents']
    @comments_rating = {}
    comments_score
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

  def comments_score
    api_rating.each do |comment|
      id = comment['id']
      comments_rating[id.to_i] = (comment['score'] * 200 - 100).to_i
    end
  end

  def comments_ids
    (0...api_rating.size).each_with_object({}) { |id, hash| hash[id] = comments[id] }
  end
end

puts CommentsRating.new('https://tech.onliner.by/2018/07/21/plane-9').rating

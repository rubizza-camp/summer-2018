require 'active_support'
require 'active_support/core_ext'

# This class calculate rating
class Rating
  attr_reader :comment_scores, :comments

   def initialize(comment_rating, comments)
    @comment_rating = comment_rating
    @comments = comments
  end

   def comment_rating(comment)
    convert_score(comment_rating[comments.index(comment)])
  end

   def article_score
    count_article_score
  end

  private

  def comment_rating(azure_score)
    ((azure_score - 0.5) * 200).round(2)
  end

  def count_article_score
    convert_scores = comment_scores.map { |score| convert_score(score) }
    total_score = convert_scores.sum
    (total_score / comments.size).round
  end
end

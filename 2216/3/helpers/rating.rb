require 'active_support'
require 'active_support/core_ext'

class Rating
  attr_reader :comment_scores, :comments

  def initialize(comment_scores, comments)
    @comment_scores = comment_scores
    @comments = comments
  end

  def comment_score(comment)
    convert_score(comment_scores[comments.index(comment)])
  end

  def article_score
    count_article_score
  end

  private

  def convert_score(azure_score)
    ((azure_score - 0.5) * 200).round
  end

  def count_article_score
    convert_scores = comment_scores.map { |score| convert_score(score) }
    total_score = convert_scores.sum
    (total_score / comments.size).round
  end
end

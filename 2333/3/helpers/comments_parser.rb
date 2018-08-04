# frozen_string_literal: true

require_relative 'article_parser.rb'
require_relative 'rating_counter.rb'

# The class that parse comments from article
class CommentsParser
  def initialize(url)
    @page = url
  end

  def texts_with_rating
    texts_from_comments.flatten.zip(comments_rating)
  end

  private

  def comments_rating
    RatingCounter.new(texts_from_comments.flatten).rating
  end

  def texts_from_comments
    @texts_from_comments ||= comments_from_article.map do |comment|
      comment.slice('text').values
    end
  end

  def comments_from_article
    ArticleParser.new(@page).comments
  end
end

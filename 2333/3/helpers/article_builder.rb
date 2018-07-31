# frozen_string_literal: true

# the class that creates an article
class ArticleBuilder
  def initialize(link)
    @link = link
  end

  def create_article
    article = Article.create(link: @link, rating: article_rating)
    CommentsBuilder.new(comments_with_rating, article).create
  end

  private

  def article_rating
    comments_with_rating.map(&:last).reduce(:+) / comments_with_rating.size
  end

  def comments_with_rating
    @comments_with_rating ||= CommentsParser.new(@link).texts_with_rating
  end
end

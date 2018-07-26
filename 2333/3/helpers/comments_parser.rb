require_relative 'article_parser.rb'

# The class that parse comments from article
class CommentsParser
  def initialize(url)
    @page = url
  end

  def texts_from_comments
    comments_from_article.map do |comment|
      comment.slice('text')
    end
  end

  def comments_from_article
    ArticleParser.new(@page).comments
  end
end

require_relative 'comments_creator'
require_relative 'specific_comment'

class ArticleCreator
  def initialize(link)
    @link = link
  end

  def rating
    comments.map(&:rating).reduce(:+) / comments.size
  end

  def comments
    @comments ||= CommentsCreator.new(@link).create
  end
end

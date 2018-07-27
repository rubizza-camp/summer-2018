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

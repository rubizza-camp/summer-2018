class CommentParser
  def initialize(node)
    @node = node
  end

  def text
    @text ||= @node.all('.news-comment__speech > div > p').map(&:text).reduce(&:+)
  end

  def rating
    @rating ||= @node.all('.like-control span').sum { |mark| mark.text.to_i }
  end
end
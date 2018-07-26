class CommentParser
  def initialize(node)
    @node = node
  end

  def text
    @text ||= @node.find('.news-comment__speech p').text
  end

  def rating
    @rating ||= @node.all('.like-control span').sum { |mark| mark.text.to_i }
  end
end
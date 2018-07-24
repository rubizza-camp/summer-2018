class Article
  MAX_COMMENTS_CAPACITY = 50

  attr_reader :comment_list
  attr_accessor :name, :link

  def initialize(name, link, comment_list)
    @name = name
    @link = description
    @comment_list = comment_list
  end

  def initialize
    @name = @link = ''
    @comment_list = []
  end

  def rate
    @comment_list.sum(&:rate)
  end

  def add_comment(comment)
    @comment_list << comment if comment_list.size <= 50
  end
end

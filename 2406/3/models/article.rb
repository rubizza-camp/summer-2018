module Models
  class Article
    MAX_COMMENTS_CAPACITY = 50

    attr_reader :comment_list, :id, :name, :link

    def initialize(id, name, link, comment_list)
      @id = id
      @name = name
      @link = link
      @comment_list = comment_list
    end

    def rate
      @comment_list.sum(&:rate) / @comment_list.size.to_f
    end
  end
end

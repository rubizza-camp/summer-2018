module Models

  class Article
    MAX_COMMENTS_CAPACITY = 50

    attr_reader :comment_list
    attr_accessor :id, :name, :link

    def initialize(id, name, link, comment_list)
      @id = id
      @name = name
      @link = link
      @comment_list = comment_list
    end

    def rate
      @comment_list.sum(&:rate)/@comment_list.size.to_f
    end

    def add_comment(comment)
      @comment_list << comment if comment_list.size <= 50
    end
  end
end

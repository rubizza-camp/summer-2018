# frozen_string_literal:true

# the class that creates a comments from articles
class CommentsBuilder
  def initialize(comments, article)
    @comments = comments
    @article = article
  end

  def create
    @comments.each do |comment|
      @article.comments.add(Comment.create(text: comment.first,
                                           rating: comment.last))
    end
  end
end

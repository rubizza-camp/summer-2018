# Class to build comments
class CommentsBuilder
  def initialize(comments, article)
    @comments = comments
    @article = article
  end

  def self.create
    @comments.each do |comment|
      Comment.create(author: comment[:author], text: comment[:text], rating: comment[:rating], article: @article)
    end
  end
end

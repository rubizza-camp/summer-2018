# this class creates comment
class CommentsBuilder
  attr_reader :comments, :post
  def initialize(comments, given_post)
    @comments = comments
    @post = given_post
  end

  # :reek:FeatureEnvy
  def create
    comments.each do |comment|
      Comment.create(author: comment[:author], text: comment[:text], rating: comment[:rating], post: post)
    end
  end
end

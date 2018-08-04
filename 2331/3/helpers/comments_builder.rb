class CommentsBuilder
  LIMIT = 50

  def initialize(comments, article)
    @comments = comments
    @article = article
  end

  # :reek:FeatureEnvy
  def create
    @comments.each do |comment|
      Comment.create(author: comment[:author], text: comment[:text], rating: comment[:rating], article: @article)
    end
  end
end

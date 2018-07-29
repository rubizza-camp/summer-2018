# Class, that contol redis models
class ModelsManager
  def initialize(link, comments)
    @link = link.link
    @comments = comments
  end

  def add_to_model
    article = ArticleModel.create(link: @link, sentiment: article_sentiment)
    @comments.each do |comment|
      comment_db = CommentModel.create(body: comment.comment, sentiment: comment.sentiment)
      article.comments.push(comment_db)
    end
    article
  end

  private

  def article_sentiment
    @comments.inject(0) { |sum, comment| sum + comment.sentiment } / @comments.count
  end
end

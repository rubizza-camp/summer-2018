# Analyse article
class ArticleAnalyser
  attr_reader :article, :text_body, :ratings

  def initialize(article)
    @article = article
    @text_body = launch_comments_parser
    @ratings = launch_rating_counter
  end

  def launch
    refresh_article_title
    build_article_stat
    refresh_article_rating
  end

  private

  def launch_comments_parser
    CommentsParser.new(article.link).launch_parser
  end

  def launch_rating_counter
    CommentRatingCounter.new(text_body).launch_counter
  end

  def refresh_article_title
    page = Mechanize.new.get(article.link)
    @article.update(title: page.title)
  end

  def build_article_stat
    text_body.each_with_index do |text, index|
      comment = Comment.create(text: text, rating: ratings[index])
      article.comments.add(comment)
    end
  end

  def refresh_article_rating
    article_rating = (ratings.sum / text_body.size).to_i
    @article.update(rating: article_rating)
  end
end

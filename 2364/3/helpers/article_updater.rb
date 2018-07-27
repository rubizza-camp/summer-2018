# Update article rating
class ArticleUpdater
  attr_reader :article, :texts, :ratings

  def initialize(article)
    @article = article
  end

  def run
    @texts = CommentsParser.new(article.link).run
    @ratings = CommentRatingCounter.new(texts).run
    update_article_title
    create_article_stat
    update_article_rating
  end

  private

  def update_article_title
    agent = Mechanize.new
    page = agent.get(article.link)
    @article.update(title: page.title)
  end

  def create_article_stat
    texts.each_with_index do |text, index|
      comment = Comment.create(text: text, rating: ratings[index])
      article.comments.add(comment)
    end
  end

  def update_article_rating
    article_rating = (ratings.sum / texts.size).to_i
    @article.update(rating: article_rating)
  end
end

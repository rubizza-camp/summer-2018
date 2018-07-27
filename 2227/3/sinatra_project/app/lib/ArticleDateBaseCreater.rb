# Create and update article rating
class ArticleDateBaseCreater
  attr_reader :article, :texts, :ratings

  def initialize(article)
    @article = article
    @texts = CommentsParser.new(article.link).parse_comments_from_page
    @ratings = CommentsRater.new(texts).create_answer
  end

  def update_db
    update_article_title
    create_article_stat
    update_article_rating
  end

  def update_article_title
    page = Mechanize.new.get(article.link)
    @article.update(title: page.title)
  end

  def create_article_stat
    texts.each_with_index { |text, index| article.comments.add(Comment.create(text: text, rating: ratings[index])) }
  end

  def update_article_rating
    article_rating = (ratings.sum / texts.size).to_i
    @article.update(rating: article_rating)
  end
end

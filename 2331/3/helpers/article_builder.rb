class ArticleBuilder
  attr_reader :article

  def initialize(options)
    @article_link = options[:article]
    @comments = ArticleParser.new(@article_link).comments
  end

  def create
    @article = Article.create(link: @article_link, title: title, rating: article_rating)
    CommentsBuilder.new(comments_with_rating, article).create
    article
  end

  private

  def article_rating
    comments_with_rating.map { |comment| comment[:rating] }.sum / @comments.size
  end

  def comments_with_rating
    CommentsReferee.new(@comments).put_ratings
  end

  def title
    ArticleParser.new(@article_link).title
  end
end

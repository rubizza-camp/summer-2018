class ArticleCreator
  def initialize(link)
    @link = link
  end

  def create
    Article.create(link: @link, rating: 0)
  end
end

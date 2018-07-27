# Class
class ArticleHelper
  def initialize(url)
    @agent = Mechanize.new { |agnt| agnt.user_agent_alias = 'Mac Safari' }
    @agent.history_added = proc { sleep 1 }
    @article = Article.create(url: url, title: retrieve_title(url))
    update_article(url)
  end

  attr_reader :agent, :article

  def retrieve_title(url)
    page = @agent.get(url)
    page.title
  end

  def update_article(url)
    helper = CommentHelper.new
    contents = helper.retrieve_comments(url)
    ratings = helper.retrieve_rating(contents)
    contents.each_with_index do |content, index|
      comment = Comment.create(content: content, rate: ratings[index])
      @article.comments.add(comment)
    end
    article_rate = (ratings.sum / comments.size).to_i
    @article.update(rating: article_rate)
  end
end

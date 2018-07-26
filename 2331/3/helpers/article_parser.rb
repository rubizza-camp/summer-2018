class ArticleParser
  def initialize(link = 'https://people.onliner.by/2018/07/23/vodol')
    @agent = Mechanize.new
    @article_link = link
  end

  def title
    @agent.get(@article_link).search('.news-header__title').text.strip
  end

  def comments
    data['comments'].reverse.map do |comment|
      { author: CommentHelper.author(comment),
        text: CommentHelper.text(comment),
        votes: CommentHelper.votes(comment) }
    end
  end

  private

  def data
    JSON.parse(@agent.get(comment_link).body)
  end

  def comment_link
    "https://comments.api.onliner.by/news/#{section}.post/#{article_id}/comments?limit=9999"
  end

  def section
    @article_link[%r{https://(\w+)}, 1]
  end

  def article_id
    @agent.get(@article_link).search('.news_view_count').attr('news_id').value
  end
end

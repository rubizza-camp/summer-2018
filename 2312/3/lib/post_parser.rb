# this class processes given link, gets all comments, and returns hash with processed data
class PostParser
  attr_reader :agent, :post_link
  def initialize(link = 'https://people.onliner.by/2018/07/23/vodol')
    @agent = Mechanize.new
    @post_link = link
  end

  def title
    agent.get(post_link).search('.news-header__title').text.strip
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
    JSON.parse(@agent.get("https://comments.api.onliner.by/news/tech.post/#{post_id}/comments?limit=50").body)
  end

  def post_id
    agent.get(post_link).search('app[entity-id]').to_s.match(/\d+/).to_s
  end
end

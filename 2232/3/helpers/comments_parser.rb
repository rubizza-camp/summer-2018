class CommentsParser
  LIMIT_COMMENTS = 50

  def initialize(page, link)
    @page = page
    @link = link
  end

  def comments
    @comments ||= response.map { |comment| [comment['author']['name'], comment['text'].tr("\n", ' ')] }
  end

  private

  def api_link
    number = @page.css('.news_view_count').attr('news_id').value
    category = @link.split('https://').last.split('.').first
    "https://comments.api.onliner.by/news/#{category}.post/#{number}/comments?limit=9999"
  end

  def rate(comment)
    comment['marks']['likes'] + comment['marks']['dislikes']
  end

  def response
    JSON.parse(Faraday.get(api_link).body)['comments'].sort_by { |comment| rate(comment) }.reverse.first(LIMIT_COMMENTS)
  end
end

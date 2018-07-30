require_relative 'sentiment_parser'
require_relative 'comment_storage'

class CommentsParser
  LIMIT_COMMENTS = 50

  def initialize(page, link)
    @page = page
    @link = link
  end

  def call
    sentiments.map do |sentiment|
      author_text = comments[sentiment['id'].to_i]
      CommentStorage.new(author_text[0], author_text[1], (sentiment['score'] * 200 - 100).to_i)
    end
  end

  private

  def sentiments
    SentimentParser.new(comments).call
  end

  def api_link
    number = @page.css('.news_view_count').attr('news_id').value
    category = @link.split('https://').last.split('.').first
    "https://comments.api.onliner.by/news/#{category}.post/#{number}/comments?limit=9999"
  end

  def comments
    @comments ||= response.map { |comment| [comment['author']['name'], comment['text'].tr("\n", ' ')] }
  end

  def rate(comment)
    comment['marks']['likes'] + comment['marks']['dislikes']
  end

  def response
    JSON.parse(Faraday.get(api_link).body)['comments'].sort_by { |comment| rate(comment) }.reverse.first(LIMIT_COMMENTS)
  end
end

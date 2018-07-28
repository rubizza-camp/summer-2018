require_relative 'sentiment_parser'
require_relative 'comment_storage'

class ArticleParser
  LIMIT_COMMENTS = 50
  attr_reader :link

  def initialize(link)
    @link = link
  end

  def title
    page.title
  end

  def rating
    comments.map(&:rating).reduce(:+) / comments.size
  end

  def comments
    @comments ||= initialize_comments
  end

  private

  def sentiments
    SentimentParser.new(comment_parser).call
  end

  def page
    @page ||= Mechanize.new.get(link)
  end

  def api_link
    number = page.css('.news_view_count').attr('news_id').value
    category = link.split('https://').last.split('.').first
    "https://comments.api.onliner.by/news/#{category}.post/#{number}/comments?limit=9999"
  end

  def comment_parser
    @comment_parser ||= response.map { |comment| [comment['author']['name'], comment['text'].tr("\n", ' ')] }
  end

  def rate(comment)
    comment['marks']['likes'] + comment['marks']['dislikes']
  end

  def response
    JSON.parse(Faraday.get(api_link).body)['comments'].sort_by { |comment| rate(comment) }.reverse.first(LIMIT_COMMENTS)
  end

  def initialize_comments
    sentiments.map do |sentiment|
      author_text = comment_parser[sentiment['id'].to_i]
      CommentStorage.new(author_text[0], author_text[1], (sentiment['score'] * 200 - 100).to_i)
    end
  end
end

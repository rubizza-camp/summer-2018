require_relative 'sentiment_parser'
require_relative 'comment_helper'

class ArticleHelper
  include SentimentParser

  LIMIT_COMMENTS = 50
  attr_reader :link, :comments

  def initialize(link)
    @link = link
    @comments = create_comments
  end

  def title
    page.title
  end

  def rating
    comments.map(&:rating).reduce(:+) / comments.size
  end

  private

  def page
    @page ||= Mechanize.new.get(link)
  end

  def api_link
    number = page.css('.news_view_count').attr('news_id').value
    category = link.split('https://').last.split('.').first
    "https://comments.api.onliner.by/news/#{category}.post/#{number}/comments?limit=9999"
  end

  def create_comments
    comments = response.each_with_object({}) { |cmt, hash| hash[cmt['author']['name']] = cmt['text'].tr("\n", ' ') }
    initialize_comments(comments, create_sentiments(comments))
  end

  def response
    JSON.parse(Faraday.get(api_link).body)['comments'][0...LIMIT_COMMENTS]
  end

  def initialize_comments(comments, sentiments)
    sentiments.each_with_object([]) do |sentiment, arr|
      author = sentiment['id']
      arr << CommentHelper.new(author, comments[author], (sentiment['score'] * 200 - 100).to_i)
    end
  end
end

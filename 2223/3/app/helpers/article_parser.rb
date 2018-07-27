require 'json'
require 'mechanize'
require 'faraday'
require 'pry'

class ArticleParser
  attr_reader :page

  def initialize(link)
    @page = Mechanize.new.get(link)
  end

  def title
    page.at('.news-header__title').text.strip
  end

  def comments
    response = JSON.parse(Faraday.get(comments_query).body)
    response['comments'].map { |comment| comment['text'] }
  end

  private

  def comments_query
    news_id = page.at('@news_id').value
    "https://comments.api.onliner.by/news/tech.post/#{news_id}/comments?"
  end
end

require 'json'
require 'mechanize'

class CommentsParser
  def initialize(link)
    @link = link
  end

  def parse
    response_as_json['comments'].map { |comment| comment['text'] }
  end

  private

  def response_as_json
    JSON.parse(response_of_server.body)
  end

  def response_of_server
    Faraday.get "https://comments.api.onliner.by/news/#{arcticle_category}.post/#{article_id}/comments?limit=50"
  end

  def arcticle_category
    @link.split('.').first.split('/').last
  end

  def article_id
    page.css('.news_view_count').attr('news_id').value
  end

  def page
    Mechanize.new.get(@link)
  end
end

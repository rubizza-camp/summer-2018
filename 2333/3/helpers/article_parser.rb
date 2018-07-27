# frozen_string_literal: true

# The class that parse url and take the comments
class ArticleParser
  LIMIT = 50
  def initialize(url)
    @page = Mechanize.new.get(url)
    @agent = Mechanize.new
  end

  def comments
    @comments = JSON.parse(@agent.get(api_url + api_path).body)['comments']
  end

  private

  def api_url
    "https://comments.api.onliner.by/news/#{article_category}.post/"
  end

  def api_path
    "#{article_id}/comments?limit=#{LIMIT}"
  end

  def article_id
    @page.search('.news_view_count').attr('news_id').value
  end

  def article_category
    @page.uri.to_s.slice(/people|tech|auto|realt/)
  end
end

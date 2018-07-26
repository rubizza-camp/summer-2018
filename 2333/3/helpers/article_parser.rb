# frozen_string_literal: true

# The class that parse url
class ArticleParser
  def initialize(url)
    @page = Mechanize.new.get(url)
    @api_url = "https://comments.api.onliner.by/news/#{article_category}.post/"
    @api_path = "#{article_id}/comments?limit=500"
  end

  def comments
    @comments = JSON.parse(Mechanize.new.get(@api_url + @api_path).body)['comments']
  end

  private

  def article_id
    @page.search('.news_view_count').attr('news_id').value
  end

  def article_category
    @page.uri.to_s.slice(/people|tech|auto|realt/)
  end
end

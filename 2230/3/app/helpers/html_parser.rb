require 'open-uri'
require 'capybara'

class HTMLParser
  COMMENTS_API_BASE_PATH = 'https://comments.api.onliner.by'.freeze
  COMMENTS_COUNT = '10'.freeze
  attr_reader :article_url
  attr_reader :comments_url, :article_title

  def initialize(article_url)
    @article_url = article_url
    @article_title = ''
  end

  def run
    page = Nokogiri::HTML(URI.parse(@article_url).read)
    @article_title = page.css('title').text
    @comments_url = generate_comments_url(page.css('div#fast-comments app'))
  end

  private

  def generate_comments_url(page)
    File.join(COMMENTS_API_BASE_PATH, '/', page.at('app')['project-name'], '/', page.at('app')['entity-type'], \
              '/', page.at('app')['entity-id'], "/comments?limit=#{COMMENTS_COUNT}")
  end
end

# url = HTMLParser.new('https://people.onliner.by/2018/07/26/profession', 3).run
# p url

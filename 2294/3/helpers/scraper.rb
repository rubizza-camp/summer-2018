require 'mechanize'
require 'date'
require 'json'
require 'pry'

# GetApiLink via link to news
class GetApiLink
  ATTRIBUTE_PATTERN = 'span[news_id]'.freeze
  attr_reader :id

  def initialize
    @agent = Mechanize.new
  end

  def detect_news_id
    page = @agent.get('https://tech.onliner.by/2018/07/24/dji-4')
    page.search(ATTRIBUTE_PATTERN).to_s.match(/\d+/).to_s
  end
end

# Parse date from api in JSON format
class ArticleParser
  URL_PATTERN = 'https://comments.api.onliner.by/news/tech.post/386437/comments?limit=500'.freeze
  def initialize
    @agent = Mechanize.new
    @id = GetApiLink.new.detect_news_id
  end

  def pull_comments
    link = URL_PATTERN.sub(/\d+/, @id)
    @page = @agent.get(link)
  end
end

# Parse JSON
class JSONParser
  def initialize
    @json = ArticleParser.new.pull_comments
  end

  def comments_options
    read_json_body['comments'].map! { |comment| comment.slice('text', 'marks') }
  end

  private

  def read_json_body
    JSON.parse(@json.body)
  end
end

# Counting rating based on count of likes and dislikes
class Helper
  def self.rating(marks)
    marks.flatten.select { |value| value.is_a?(Integer) }.sum
  end
end

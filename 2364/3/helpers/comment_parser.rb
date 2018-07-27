require 'json'
require 'mechanize'

# Parse comments from page
class CommentsParser
  attr_reader :agent, :path

  def initialize(link)
    @agent = Mechanize.new
    @path = link
  end

  def run
    parse_comments_from_page
  end

  private

  def parse_comments_from_page
    resp = parse_comments
    comments = JSON.parse(resp.body)['comments']
    create_text = ->(comment) { comment['text'].tr("\n", ' ') }
    comments.map(&create_text)
  end

  def parse_comments
    code = parse_code_of_page
    url = "https://comments.api.onliner.by/news/tech.post/#{code}/comments?limit=50&_=0.9841189675826583"
    agent.get(url)
  end

  def parse_code_of_page
    page = agent.get(path)
    page.parser.css('span.news_view_count').last.values[1]
  end
end

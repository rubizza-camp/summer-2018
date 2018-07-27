require 'json'
require 'mechanize'

# Comments parser
class CommentsParser
  attr_reader :agent, :path_to_page

  def initialize(link)
    @agent = Mechanize.new
    @path_to_page = link
  end

  def launch_parser
    parse_comments_from_page
  end

  private

  def parse_comments_from_page
    response = parse_comments
    comments = JSON.parse(response.body)['comments']
    comments.map do |elem|
      elem['text'].sub("\n", ' ')
    end
  end

  def parse_page_code
    agent.get(path_to_page).parser.css('span.news_view_count').last.values[1]
  end

  def parse_comments
    on_url = "https://comments.api.onliner.by/news/tech.post/#{parse_page_code}/comments?limit=100&_=0.9046614793472092"
    agent.get(on_url)
  end
end

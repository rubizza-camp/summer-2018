require 'json'
require 'mechanize'

# This is class handling comments for post across API onliner.by
class CommentsParser
  LIMIT      = 50
  API_PATH   = 'https://comments.api.onliner.by/news/tech.post/'.freeze
  API_PARAMS = "/comments?limit=#{LIMIT}&_=0.9841189675826583".freeze
  attr_reader :agent

  def initialize
    @agent = Mechanize.new
  end

  def perform(url)
    page_post    = agent.get(url)
    post_id      = page_post.search('span.news_view_count').first.values[1]
    comment_list = agent.get(API_PATH + post_id + API_PARAMS)
    handling_comments(comment_list)
  end

  def self.fetch_title(url)
    agent = Mechanize.new
    agent.get(url).title
  end

  private

  def handling_comments(comment_list)
    body = comment_list.body
    JSON.parse(body)['comments'].each_with_object([]) do |comment, comments|
      comments << comment['text'].gsub("\n", '<br>')
    end
  end
end

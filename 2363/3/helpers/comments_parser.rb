# frozen_string_literal: true

require 'json'
require 'mechanize'

# This get lilk of post onliner.by and return comments from this post
class CommentsParser
  COMMENTS_LIMIT = 50
  API_PATH = 'https://comments.api.onliner.by/news/tech.post/'.freeze
  API_PARAMS = "/comments?limit=#{COMMENTS_LIMIT}&_=0.9841189675826583".freeze
  attr_reader :agent, :path

  def initialize(path)
    @path = path
    @agent = Mechanize.new
  end

  def run
    page = agent.get(path)
    id_of_post = page.parser.css('span.news_view_count').last.values[1]
    page = agent.get(API_PATH + id_of_post + API_PARAMS)
    prepare_comments(page)
  end

  private

  def prepare_comments(page)
    JSON.parse(page.body)['comments'].map do |comment|
      comment['text'].tr("\n", ' ')
    end
  end
end

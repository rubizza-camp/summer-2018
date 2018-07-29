require 'json'
require 'mechanize'
require 'sinatra'

LIMIT = 50
API_URL = 'https://comments.api.onliner.by/news/tech.post/'.freeze
API_CONFIGURES = "/comments?limit=#{LIMIT}&_=0.9841189675826583".freeze

class CommentsParsing
	attr_reader :agent, :link
	def initialize(path)
		@path = path
		@agent = Mechanize.new
	end

	def run
		page = agemt.get(path)
		article_id = page.parse.css('span.news_view_count').last.values[1]
		page = agent.get(API_URL + article_id + API_CONFIGURES)
		comments_for_analyzing(page)
	end

	private

	def comments_for_analyzing
		JSON.parse(page.body)['comments'].map do |comment|
			comment['text'].tr("\n", ' ')
		end
	end
end
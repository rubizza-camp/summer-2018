require 'ohm'
require 'sinatra'
require 'redis'
require 'mechanize'
require 'net/https'
require 'uri'
require 'json'

# Parser

class Parser
	attr_reader :page_id, :comments_response, :comments_uri
  def initialize(link_obj)
		@link = link_obj
	end

	def comments
		page_id = get_page_id
		comments_uri = make_comments_uri
		comments_response = get_comments_page
		make_comments_list
	end

	private

	def get_page_html
		Net::HTTP.get_response(URI.parse(@link)).body
	end

	def get_comments_page
		Net::HTTP.get_response(comments_uri).body
	end

	def get_page_id
		Nokogiri::HTML(get_page_html).xpath('//span[@news_id]').to_s.match(/\d+/).to_s
	end

	def make_comments_uri
		URI.parse('https://comments.api.onliner.by/news/tech.post/' + page_id + '/comments?limit=50')
	end

	def make_comments_list
		json_comments = JSON.parse(comments_response)
		json_comments['comments'].each_with_object([]) { |comment, array| array << comment['text'] }
  end
end

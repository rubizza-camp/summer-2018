require 'mechanize'
require 'net/https'
require 'uri'
require 'json'

class Parser
	def initialize(link_obj)
		@link = link_obj
	end

	def comments
		page_id = page_id(get_page_html)
		comments_uri = make_comments_uri(page_id)
		comments_response = get_comments_page(comments_uri)
		make_comments_list(comments_response)
	end

	private

	def get_page_html
		Net::HTTP.get_response(URI.parse(@link.link)).body
	end

	def get_comments_page(comments_uri)
		Net::HTTP.get_response(comments_uri).body
	end

	def page_id(page_html)
		Nokogiri::HTML(page_html).xpath('//span[@news_id]').to_s.match(/\d+/).to_s
	end

	def make_comments_uri(page_id)
		URI.parse('https://comments.api.onliner.by/news/tech.post/' + page_id + '/comments?limit=50')
	end

	def make_comments_list(comments_response)
		json_comments = JSON.parse(comments_response)
		json_comments['comments'].each_with_object([]) { |comment, array| array << comment['text'] }
	end
end

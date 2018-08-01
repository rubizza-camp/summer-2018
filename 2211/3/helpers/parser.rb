require 'ohm'
require 'sinatra'
require 'redis'
require 'mechanize'
require 'net/https'
require 'uri'
require 'json'

# Parser

class Parser
<<<<<<< HEAD
  COMMENTS_API = 'https://comments.api.onliner.by/news/tech.post/'
  COMMENTS_LIMIT = '/comments?limit=50'
=======
  attr_reader :comments_uri
  COMMENTS_API = 'https://comments.api.onliner.by/news/tech.post/'.freeze
  COMMENTS_LIMIT = '/comments?limit=50'.freeze
>>>>>>> edf11ba0e6b7714c3ea21e3ce2de39624a41164c
  def initialize(link_obj)
    @link = link_obj
  end

  def comments
    comments_list
  end

  private

  def page_html
    Net::HTTP.get_response(URI.parse(@link)).body
  end

  def comments_page
    Net::HTTP.get_response(comments_uri).body
  end

  def page_id
    Nokogiri::HTML(page_html).xpath('//span[@news_id]').to_s.match(/\d+/).to_s
  end

  def comments_uri
    URI.parse(COMMENTS_API + page_id + COMMENTS_LIMIT)
  end

  def mments_list
    json_comments = JSON.parse(comments_page)
    json_comments['comments'].each_with_object([]) { |comment, array| array << comment['text'] }
  end
end

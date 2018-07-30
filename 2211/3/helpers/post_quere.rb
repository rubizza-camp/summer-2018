require 'ohm'
require 'sinatra'
require 'redis'
require 'mechanize'
require 'net/https'
require 'uri'
require 'json'
require_relative 'link_filling'
require_relative 'parser'

# Make Quere

class PostQuery
  def initialize(link)
    @uri = URI('https://westcentralus.api.cognitive.microsoft.com/text/analytics/v2.0/sentiment')
    @link = link
    @documents = {}
    @documents['documents'] = []
  end

  def query
    all_comments_texts = []
    comments_in_article = Parser.new(@link).comments
    comments_in_article.each do |comment|
      comments_with_id(comments_in_article.index(comm), comment.to_s, all_comments_texts)
    end
    LinkFIlling.new(become_response, @documents, all_comments_texts, @link).filling
  end

  def comments_with_id(index, comment, all_comments_texts)
    @documents['documents'] << { 'id' => index.to_s, 'text' => comment }
    all_comments_texts << comment
  end

  def make_request
    request = Net::HTTP::Post.new(@uri)
    request.set_form_data('Content-Type' => 'application/json', 'Ocp-Apim-Subscription-Key' => @access_key)
    @documents.to_json
  end

  def become_response
    Net::HTTP.start(@uri.host, @uri.port, use_ssl: @uri.scheme == 'https') do |http|
      http.request(make_request)
    end
  end
end

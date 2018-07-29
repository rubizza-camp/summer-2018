require 'ohm'
require 'sinatra'
require 'redis'
require 'mechanize'
require 'net/https'
require 'uri'
require 'json'
require_relative 'LinkFilling'
require_relative 'Parser'

# Make Quere

class PostQuery
  attr_reader :request
  def initialize(link)
    @access_key = '8af30e06989641a7bab5f00d678b9c4d'
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

  # rubocop: disable Lint/UselessSetterCall
  def make_request
    request = Net::HTTP::Post.new(@uri)
    request['Content-Type'] = 'application/json'
    request['Ocp-Apim-Subscription-Key'] = @access_key
    request.body = @documents.to_json
  end
  # rubocop: enable Lint/UselessSetterCall

  def become_response
    make_request
    Net::HTTP.start(@uri.host, @uri.port, use_ssl: @uri.scheme == 'https') do |http|
      http.request(request)
    end
  end
end

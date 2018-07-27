require 'ohm'
require 'sinatra'
require 'redis'
require 'pry'

require 'mechanize'
require 'net/https'
require 'uri'
require 'json'

Ohm.redis = Redic.new

get '/' do
  erb :index
end

get '/add'do
  erb :add
end

post '/add' do
  @l = PostQuery.new(params[:link]).query
  @addresses = Link.all.map(&:address)
  @rates = Link.all.map(&:rate)
  erb :show
end

get '/comments_analysis/:id' do
  @comments = Link[params[:id]].comments.to_a
  erb :analysis
end

post '/comments_analysis/:id' do
 "ff"
end

class PostQuery
  def initialize(link)
    @accessKey = '8af30e06989641a7bab5f00d678b9c4d'
    @uri = URI('https://westcentralus.api.cognitive.microsoft.com/text/analytics/v2.0/sentiment')
    @link = link
    @documents = {}
    @documents['documents'] = []
  end

  def query
    comments_on_article = Parser.new(@link).comments
    comments = []
    comments_on_article.each do |comm|
      @documents['documents'] << {'id' => "#{comments_on_article.index(comm)}", 'text' => "#{comm}"} 
      comments << "#{comm}"
    end
    link_filling(comments)
  end

  def comment_rate
    @request = Net::HTTP::Post.new(@uri)
    @request['Content-Type'] = "application/json"
    @request['Ocp-Apim-Subscription-Key'] = @accessKey
    @request.body = @documents.to_json

    @response = Net::HTTP.start(@uri.host, @uri.port, :use_ssl => @uri.scheme == 'https') do |http|
      http.request (@request)
    end
    scores = []
    (JSON (@response.body))['documents'].each do |elem| 
      scores << elem['score']
    end
  end

  def link_filling(comments)
    l = Link.create(address: "#{@link}", rate: "#{avr(comment_rate)}")
    comments.each do |com| 
      l.comments.push(Comment.create(text: com, rate: (JSON (@response.body))['com']))
    end
  end

  def avr(all_scores)
    article_acore = 0
    all_scores.each { |a| article_acore += a["score"] }
    article_acore /= all_scores.size
    article_acore * 200 - 100
  end
end

class Link < Ohm::Model
  attribute :address
  attribute :rate
  list :comments, :Comment
end

class Comment < Ohm::Model
  attribute :text
  attribute :rate
end

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
		Net::HTTP.get_response(URI.parse(@link)).body
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

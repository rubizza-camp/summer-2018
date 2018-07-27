require 'sinatra'
require 'ohm'

class ApplicationController < Sinatra::Base
	set :views, File.expand_path(File.join(__FILE__, '../../views'))

	get '/' do
		@article = Article
		erb :main_view
	end

	post '/addlink' do
		link = OnlinerLink.new(params[:link])
		if link.verified? 
      comments = LinkExplorer.new(link, 'de0f5ae352a34914b6134a4fe9a06040').explore
      article_sentiment = article_sentiment(comments)
      @article = add_to_redis_model(link, comments, article_sentiment)
			erb :main_view
		else
			erb :wrong_link
		end
	end

	post '/cleardb' do
		Ohm.redis.call("FLUSHALL")
		@links = Ohm.redis.call("LRANGE", "links", 0, -1)
		erb :main_view
	end
end

def article_sentiment(comments)
  comments.inject { |sum, comment| sum + comment.comment } / comments.count
end

def add_to_redis_model(link, comments, sentiment)
  article = Article.create(:link => link.link, :sentiment => sentiment)
  comments.each { |com| article.comments.push(Comment.create(:body => com.comment, :sentiment => com.sentiment)) }
  article
end



#comments = Parser.new('https://tech.onliner.by/2018/07/24/russkie-xakery').comments
#values = comments.each_with_object([]) { |comment, array| array << AZURESentimentAnalyzer.new('de0f5ae352a34914b6134a4fe9a06040').analyze(comment) }
#puts values




#Ohm.redis = Redic.new("redis://127.0.0.1:6379")
#Ohm.redis.call "RPUSH", "links", params[:link]
#Ohm.redis.call "LRANGE", "links", 0, -1

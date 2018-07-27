require 'sinatra'
require 'ohm'
require 'pry'
require_relative '/home/alexandr/MyFolder/projects/onliner_analizer/helpers/database_models.rb'

# Main controller
class ApplicationController < Sinatra::Base
  set :views, File.expand_path(File.join(__FILE__, '../../views'))

  get '/' do
    @articles = Article.all
    erb :main_view
  end

  post '/addlink' do
    link = OnlinerLink.new(params[:link])
    if link.verified?
      comments = LinkExplorer.new(link, File.read('./.key')).explore
      article_sentiment = article_sentiment(comments)
      add_to_redis_model(link, comments, article_sentiment)
      @articles = Article.all
      erb :main_view
    else
      erb :wrong_link
    end
  end

  post '/cleardb' do
    Ohm.redis.call('FLUSHALL')
    @articles = Article.all
    erb :main_view
  end

  get '/analysis/:id' do
    @comments = Article[params[:id]].comments
    erb :analysis
  end
end

def article_sentiment(comments)
  comments.inject(0) { |sum, comment| sum + comment.sentiment } / comments.count
end

def add_to_redis_model(link, comments, sentiment)
  article = Article.create(link: link.link, sentiment: sentiment)
  comments.each do |com|
    comdb = CommentDB.create(body: com.comment, sentiment: com.sentiment)
    article.comments.push(comdb)
  end
  article
end

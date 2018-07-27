require 'sinatra'
require 'ohm'
require_relative 'models/article'
require_relative 'models/comment'
require_relative 'helpers/app_helper'

set :views, File.expand_path('./views', __dir__)

Article.redis = Redic.new('redis://127.0.0.1:6379')
Comment.redis = Redic.new('redis://127.0.0.1:6379')

# show all articles
get '/' do
  @articles = Article.all
  erb :articles
end

# add new article
get '/new' do
  erb :new
end

# create a new article
post '/new' do
  obj = AppHelper.new(params[:link]).article
  @article = Article.create link: params[:link], rating: obj.rating
  obj.comments.map do |comment|
    @article.comments.add(Comment.create(text: comment.text, author: comment.author, rating: comment.rating))
  end
  erb :show
end

# show article
get '/show/:id' do
  @article = Article.all[params[:id]]
  erb :show
end

# delete article
delete '/:id' do
  article = Article.all[params[:id]]
  article.delete
  redirect '/articles'
end

# delete all articles
delete '/' do
  Article.all.each(&:delete)
  redirect '/articles'
end

run Sinatra::Application.run!
require_relative './application_controller.rb'

# Controller
class ArticlesController < ApplicationController
  # index
  get '/' do
    @articles = Article.all
    erb :'/articles/index'
  end

  # new
  get '/new' do
    erb :'/articles/create'
  end

  # show
  get '/:id' do
    @article = Article[params[:id]]
    erb :'/articles/show'
  end

  # create
  post '/' do
    ArticleHelper.new(params[:url])
    redirect '/'
  end

  # delete
  delete '/:id' do
    Article[params[:id]].comments.each(&:delete)
    Article[params[:id]].delete
    redirect '/'
  end
end

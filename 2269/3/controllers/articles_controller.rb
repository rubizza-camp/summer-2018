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
    params[:id]
  end

  # create
  post '/' do
    ArticleHelper.new(params[:url])
    redirect '/'
  end

  # put
  put '/:id' do
    params[:id]
  end

  # delete
  delete '/:id' do
    params[:id]
  end
end

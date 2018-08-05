require_relative './application_controller.rb'

class ArticlesController < ApplicationController
  get '/' do
    @articles = Article.all
    erb :'/articles/index'
  end

  get '/new' do
    erb :'/articles/create'
  end

  post '/' do
    @article = ArticleCreater.new(params).create
    redirect to '/'
  end

  get '/:id' do
    @article = Article[params[:id]]
    @comments = @article.comments
    erb :'/articles/show'
  end

  delete '/:id' do
    Article[params[:id]].delete
    redirect to '/'
  end

  post '/:id' do
    @article = Article[params[:id]]
    @article.update(link: params[:article])
    redirect to "/#{params[:id]}"
  end
end

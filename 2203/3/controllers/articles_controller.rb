require_relative './application_controller.rb'

# Class with oath to set Sinatra path
class ArticlesController < ApplicationController
  get '/' do
    @articles = Article.all
    haml :'/articles/index'
  end

  get '/new' do
    haml :'/articles/create'
  end

  post '/' do
    @article = ArticleBuilder.new(params).create
    redirect to '/'
  end

  get '/:id' do
    @article = Article[params[:id]]
    @comments = @article.comments
    haml :'/articles/show'
  end

  get '/:id/edit' do
    @article = Article[params[:id]]
    haml :'articles/edit'
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

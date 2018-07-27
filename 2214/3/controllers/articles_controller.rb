require_relative 'application_controller'

class ArticlesController < ApplicationController
  get '/' do
    @articles = Article.all
    slim :index
  end

  get '/add' do
    slim :add
  end

  post '/add' do
    article = ArticleCreator.new(params[:link])
    article_db = Article.create link: params[:link], rating: article.rating
    article.comments.map { |coment| article_db.comments.add(Comment.create(text: coment.text, rating: coment.rating)) }
    redirect '/articles'
  end

  get '/:id' do
    @article = Article.all[params[:id]]
    slim :show_article
  end

  delete '/:id' do
    Article.all[params[:id]].delete
    redirect '/articles'
  end

  delete '/' do
    Article.all.each(&:delete)
    redirect '/articles'
  end
end

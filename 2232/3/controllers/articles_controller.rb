require_relative 'application_controller'

class ArticlesController < ApplicationController
  set :views, File.expand_path('../views/articles', __dir__)

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
    article_parse = ArticleHelper.new(params[:link])
    @article = Article.create(title: article_parse.title, link: params[:link], rating: article_parse.rating)
    article_parse.comments.map do |comment|
      @article.comments.add(Comment.create(text: comment.text, author: comment.author, rating: comment.rating))
    end
    erb :show
  end

  # show article
  get '/:id' do
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
end

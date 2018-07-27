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
    obj = ArticleHelper.new(params[:link])
    @article = Article.create title: obj.title, link: params[:link], rating: obj.rating
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

  # I could not use the DELETE route(https://gist.github.com/victorwhy/45bb5637cd3e7e879ace). If you read this :) HELP
  # delete article
  post '/:id' do
    article = Article.all[params[:id]]
    article.delete
    redirect '/articles'
  end

  # delete all articles
  post '/' do
    Article.all.each(&:delete)
    redirect '/articles'
  end
end

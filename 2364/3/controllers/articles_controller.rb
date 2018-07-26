# Controller for artical model
class ArticlesController < ApplicationController
  get '/article/add' do
    erb :add_view
  end

  post '/article/add' do
    article = Article.create(link: params['link'])
    ArticleUpdater.new(article).run
    redirect '/'
  end

  get '/article/:id' do
    @articles = Article.all
    @article = @articles[params[:id]]
    erb :article_view
  end

  post '/article/delete/:id' do
    @articles = Article.all
    @article = @articles[params[:id]]
    @article.delete
    redirect '/'
  end

  get '/' do
    @articles = Article.all
    erb :show_view
  end
end

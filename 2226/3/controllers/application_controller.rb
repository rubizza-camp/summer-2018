# App controller
class ApplicationController < Sinatra::Base
  set :views, File.expand_path(File.join(__FILE__, '../../views'))

  get '/' do
    @articles = Article.all
    erb :index
  end

  get '/article/add' do
    erb :new
  end

  get '/article/:id' do
    @articles = Article.all
    @article = @articles[params[:id]]
    erb :show
  end

  post '/article/add' do
    article = Article.create(link: params['link'])
    ArticleAnalyser.new(article).launch
    redirect '/'
  end

  delete '/articles/:id/delete' do
    @articles = Article.all
    @article = @articles[params[:id]]
    @article.delete
    redirect '/'
  end
end

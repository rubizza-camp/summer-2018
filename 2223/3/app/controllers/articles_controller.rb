class ArticlesController < Sinatra::Base
  set :views, File.expand_path(File.join(__FILE__, '../../views'))

  get '/' do
    erb :new
  end

  get '/articles/new' do
    erb :new
  end

  post '/articles' do
    @article = UploadArticle.call(params[:link])
    redirect "/articles/#{@article.id}"
  end

  get '/articles/:id' do
    @article = Article[params[:id]]
    erb :index
  end

  get '/articles' do
    @articles = Article.all
    erb :show
  end
end

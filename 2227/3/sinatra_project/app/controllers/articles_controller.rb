# Controller Sinatra
# rubocop:disable Metrics/AbcSize, Metrics/MethodLength
# This method smells of :reek:DuplicateMethodCall
# This method smells of :reek:TooManyStatements
module ArticlesController
  def self.registered(app)
    app.get '/article/create' do
      erb :create_article
    end

    app.post '/article/create' do
      article = Article.create(link: params['link'])
      ArticleDateBaseCreater.new(article).update_db
      redirect '/'
    end

    app.get '/article/:id' do
      @articles = Article.all
      @article = @articles[params[:id]]
      erb :show_comments
    end

    app.get '/' do
      @articles = Article.all
      erb :show_article
    end
  end
end
# rubocop:enable Metrics/AbcSize, Metrics/MethodLength

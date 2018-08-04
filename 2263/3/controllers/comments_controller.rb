# Comments controller
class CommentsController < ApplicationController
  get '/' do
    @articles = ArticleModel.all
    erb :main_view
  end

  post '/addlink' do
    link = OnlinerLink.new(params[:link])
    if link.verified?
      comments = LinkExplorer.new(link, File.read('./.key')).explore
      ModelsManager.new(link, comments).add_to_model
      @articles = ArticleModel.all
      erb :main_view
    else
      erb :wrong_link
    end
  end

  get '/cleardb' do
    Ohm.redis.call('FLUSHALL')
    @articles = ArticleModel.all
    erb :main_view
  end

  get '/analysis/:id' do
    @comments = ArticleModel[params[:id]].comments
    erb :analysis
  end
end

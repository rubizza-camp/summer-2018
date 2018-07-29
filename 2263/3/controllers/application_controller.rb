require 'sinatra'
require 'ohm'
require 'pry'
require_relative '/home/alexandr/MyFolder/projects/onliner_analizer/helpers/database_models.rb'

# Main controller
class ApplicationController < Sinatra::Base
  set :views, File.expand_path(File.join(__FILE__, '../../views'))

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

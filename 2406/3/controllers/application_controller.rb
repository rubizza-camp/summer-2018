require_relative '../models/article.rb'
class ApplicationController < Sinatra::Base
  set :views, File.expand_path(File.join(__FILE__, '../../views'))
  get '/' do
    @article_list = [] # Load form DB
    slim :'/index'
  end

  post '/' do
    @article_list = [] # Load form DB
    #params[:link] Add link to database
    slim :'/index'
  end
end

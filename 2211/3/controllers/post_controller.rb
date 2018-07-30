require 'sinatra/config_file'

# controller for posts

class PostsController < ApplicationController
  get '/' do
    erb :index
  end

  get '/add' do
    erb :add
  end

  post '/add' do
    @link = PostQuery.new(params[:link]).query
    erb :show
  end

  get '/comments_analysis/:id' do
    @comments = Link[params[:id]].comments.to_a
    erb :analysis
  end

  post '/comments_analysis' do
    erb :show
  end
end

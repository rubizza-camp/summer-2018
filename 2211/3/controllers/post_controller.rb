require 'sinatra'
require_relative 'models/LinkFilling'
require_relative 'models/Parser'
require_relative 'models/PostQuere'

# controller fir posts

class PostsController < Sinatra::Base
  get '/' do
    erb :index
  end

  get '/add' do
    erb :add
  end

  post '/add' do
    @link = PostQuery.new(params[:link]).query
    @addresses = Link.all.map(&:address)
    @rates = Link.all.map(&:rate)
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
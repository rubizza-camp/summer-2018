require 'sinatra'
require 'pry'

class ApplicationController < Sinatra::Base
  set views: 'views/'

  get '/' do
    erb :index
  end

  get '/new' do
    erb :new
  end

  post '/analyze' do
    binding.pry
    OnlinerPageParser.new(params[:link]).top_comment_texts
  end
end
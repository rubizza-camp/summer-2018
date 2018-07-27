require_relative './application_controller.rb'

class ArticleController < ApplicationController
  get '/' do
    @title = 'Index'
    erb :index
  end

  not_found do
      status 404
      erb :not_found
    end

  get '/registration' do
    @title = 'Registration'
    erb :registration
  end

  get '/article' do
    @title = 'Article'
    @array = Analyze.new.sort_comments
    erb :article
  end

  post '/registration' do
    @link = params[:link]
    ArticleCreator.new(@link).create
    redirect '/'
  end
end
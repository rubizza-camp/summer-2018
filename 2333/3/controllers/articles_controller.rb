# frozen_string_literal: true

require_relative 'application_controller.rb'
require 'erb'

# articles controller
class ArticlesController < ApplicationController
  get '/' do
    redirect '/articles'
  end

  get '/articles' do
    @articles = Article.all
    erb :index
  end

  get '/articles/new' do
    erb :add_article
  end

  post '/articles' do
    Article.all.each do |article|
      article.delete if article.link == params[:link]
    end
    ArticleBuilder.new(params[:link]).create_article
    redirect '/articles'
  end

  get '/articles/:id' do
    @articles = Article.all
    @article = @articles[params[:id]]
    erb :comments
  end

  delete '/articles/:id' do
    @article = Article.all[params[:id]]
    @article.delete
    redirect '/articles'
  end

  delete '/articles' do
    Article.all.each(&:delete)
    redirect '/articles'
  end
end

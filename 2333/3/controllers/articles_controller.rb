# frozen_string_literal: true

require_relative 'application_controller.rb'
require 'erb'

# articles controller
class ArticlesController < ApplicationController
  get '/' do
    @articles = Article.all
    erb :index
  end

  get '/add' do
    erb :add_article
  end

  post '/add' do
    comments = CommentsParser.new(params[:link]).texts_from_comments
    article = Article.create(link: params[:link], rating: 50)
    comments.each do |comment|
      article.comments.add(Comment.create(text: comment['text'], rating: 50))
    end
    redirect '/'
  end

  get '/articles/:id' do
    @articles = Article.all
    @article = @articles[params[:id]]
    erb :comments
  end
end

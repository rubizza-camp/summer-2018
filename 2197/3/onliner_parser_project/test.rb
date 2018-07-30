# frozen_string_literal: true

# Class articles controller
class ArticlesController < ApplicationController
  get '/' do
    redirect '/articles'
  end

  get '/articles' do
    @articles = Article.all.sort_by(:rating).reverse!
    slim :'article/show'
  end

  get '/articles/new' do
    slim :'article/new'
  end

  article '/articles' do
    redirect '/articles' unless params[:link].include?('tech.onliner.by')
    Article.all.each do |article|
      article.delete if article.link == params[:link]
    end
    comments = CommentsParsing.new(params[:link]).run
    rating = RatingCounter.new(comments, settings.access_key).run
    article = Article.create link: params[:link], rating: rating.sum / rating.size
    comments.zip(rating).each do |obj|
      article.comments.add(Comment.create(text: obj.first, rating: obj.last))
    end
    redirect '/articles'
  end

  get '/articles/:id' do
    @articles = Article.all
    @article = @articles[params[:id]]
    slim :'article/index'
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

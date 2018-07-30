require 'sinatra'
require 'pry'

# Articles controller class
class ArticlesController < ApplicationController 
	get '/' do 
		redirect '/articles'
	end

	get '/articles' do
		@articles = Article.all.sort_by(:rating).reverse!
		erb :'articles/show'
	end

	get '/articles/new' do 
		erb :'articles/new'
	end

	post '/articles' do
		redirect '/articles' unless params[:link].include?("tech.onliner.by")
		all_articles = Article.all
		all_articles.each do |article|
			article.delete if article.link == params[:link]
		end
		comments = CommentsParsing.new(params[:link]).run
		rating_s = RatingCounter.new(comments, settings.access_key).run
		article = Article.create link: params[:link], rating: rating_s.sum / rating_s.size\
		comments.zip(rating).each do |object|
			article.comments.add(Comment.create(text: object.first, rating: object.last))
		end
		redirect '/articles'
	end

	delete 'articles/:id' do
		@article = Articles.all[params[:id]]
		@article.delete
		erb :'articel/index'
	end

	delete '/articles' do
		Article.all.each(&:delete)
			redirect '/articles'
		end
	end
end
# frozen_string_literal: true

# Class posts controller

class PostsController < ApplicationController
  get '/' do
    redirect '/posts'
  end
  get '/posts' do
    @posts = Post.all.sort_by(:rating).reverse!
    slim :'post/show'
  end
  get '/posts/new' do
    slim :'post/new'
  end
  post '/posts' do
    redirect '/posts' unless params[:link].include?('tech.onliner.by')
    Post.all.each do |post|
      post.delete if post.link == params[:link]
    end
    comments = CommentsParser.new(params[:link]).run
    rating = CountRating.new(comments, settings.access_key).run
    post = Post.create link: params[:link], rating: rating.sum / rating.size
    comments.zip(rating).each do |obj|
      post.comments.add(Comment.create(text: obj.first, rating: obj.last))
    end
    redirect '/posts'
  end
  get '/posts/:id' do
    @posts = Post.all
    @post = @posts[params[:id]]
    slim :'post/index'
  end
  delete '/posts/:id' do
    @post = Post.all[params[:id]]
    @post.delete
    redirect '/posts'
  end
  delete '/posts' do
    Post.all.each(&:delete)
    redirect '/posts'
  end
end

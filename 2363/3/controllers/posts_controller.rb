# frozen_string_literal: true

# Class posts controller
class PostsController < ApplicationController
  get '/' do
    @posts = Post.all.sort_by(:rating).reverse!
    slim :'post/show'
  end

  get '/add' do
    slim :'post/add'
  end

  post '/add' do
    redirect '/' unless params[:link].include?('tech.onliner.by')
    Post.all.each do |post|
      post.delete if post.link == params[:link]
    end
    comments = CommentsParser.new.run(params[:link])
    rating = CountRating.new.run(comments)
    post = Post.create link: params[:link], rating: rating.sum / rating.size
    comments.zip(rating).each do |obj|
      post.comments.add(Comment.create(text: obj.first, rating: obj.last))
    end
    redirect '/'
  end

  get '/post/:id' do
    @posts = Post.all
    @post = @posts[params[:id]]
    slim :'post/index'
  end

  delete '/post/delete/:id' do
    @post = Post.all[params[:id]]
    @post.delete
    redirect '/'
  end

  delete '/post/delete_all' do
    Post.all.each(&:delete)
    redirect '/'
  end
end

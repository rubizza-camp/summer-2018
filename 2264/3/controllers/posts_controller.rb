require 'sinatra'

class PostsController < ApplicationController

  get '/posts/new' do
    erb :'post/new'
  end

  get '/posts' do
    @posts = Post.all
    erb :'post/index'
  end

  get '/post/:id' do
    @posts = Post.all
    @post = @posts[params[:id]]
    erb :'post/show'
  end

  post '/posts' do
    post = Post.create link: params[:link]
    PostAnalyser.new(post).launch
    redirect '/posts'
  end

  delete '/posts/:id/delete' do
    @post = Post.all[params[:id]]
    @post.delete
    redirect '/posts'
  end
end


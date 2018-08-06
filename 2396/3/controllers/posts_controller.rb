# This is class PostsController
class PostsController < ApplicationController
  get '/' do
    @posts = Post.all
    erb :'posts/index'
  end
  get '/new' do
    erb :'posts/new'
  end

  post '/create' do
    Post.all.each do |post|
      post.delete if post.link == params[:link]
    end
    PostWorker.perform_async(params[:link])
    sleep 2
    redirect '/'
  end

  get '/delete/:id' do
    @post = Post.all[params[:id]]
    @post.delete
    redirect '/'
  end

  get '/:id' do
    @posts = Post.all
    @post = @posts[params[:id]]
    erb :'posts/show'
  end
end

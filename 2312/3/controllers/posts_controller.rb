require_relative './application_controller.rb'

# posts controller
class PostsController < ApplicationController
  get '/' do
    @posts = Post.all
    erb :'/posts/index'
  end

  get '/new' do
    erb :'/posts/create'
  end

  post '/' do
    @post = PostBuilder.new(params).create
    redirect to '/'
  end

  get '/:id' do
    @post = Post[params[:id]]
    @comments = @post.comments
    erb :'/posts/show'
  end

  get '/:id/edit' do
    @post = Post[params[:id]]
    erb :'posts/edit'
  end

  delete '/:id' do
    Post[params[:id]].delete
    redirect to '/'
  end

  post '/:id' do
    @post = Post[params[:id]]
    @post.update(link: params[:post])
    redirect to "/#{params[:id]}"
  end
end

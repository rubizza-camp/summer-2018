require 'sinatra'
require 'pry'
# class ApplicationController
class ApplicationController < Sinatra::Base
  set views: 'views/'

  get '/' do
    redirect '/pages'
  end

  get '/pages' do
    @pages = Page.all
    erb :index
  end

  get '/pages/new' do
    erb :new
  end

  get '/pages/:id' do
    @page = Page[params[:id]]
    erb :show
  end

  post '/pages' do
    link = params[:link]
    @page = Page.find(link: link).first
    unless @page
      comment_texts = OnlinerPageParser.new(link).top_comment_texts
      comments_with_score = CommentAnalyzer.new(comment_texts).analyze
      @page = Page.create(link: link)
      comments_with_score.each do |comment_data|
        Comment.create(comment_data.merge(page: @page))
      end
    end
    erb :show
  end
end

require 'sinatra'
require 'pry'

class ApplicationController < Sinatra::Base
  set views: 'views/'

  get '/' do
    erb :index
  end

  get '/new' do
    erb :new
  end

  post '/analyze' do
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
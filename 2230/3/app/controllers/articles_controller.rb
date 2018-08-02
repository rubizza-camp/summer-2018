require_relative './application_controller'

class ArticlesController < ApplicationController
  # index - show list of articles
  get '/' do
    # settings.views
    @articles = Article.all.sort_by(:rating).reverse!
    slim :'articles/show'
  end

  # new - add new article
  get '/new' do
    slim :'articles/new'
  end

  post '/' do
    # very simple validation
    redirect 'articles' unless params[:article_new].include?('onliner.by')
    html_parser = HTMLParser.new(params[:article_new])
    comments_url = html_parser.run
    comments = JSONParser.new(comments_url).comments
    rating = AzureSender.new(comments, settings.access_key).run
    article = Article.create url: params[:article_new], title: html_parser.article_title, rating: rating.sum / rating.size
    comments.zip(rating).each do |obj|
      Comment.create(text: obj.first, rating: obj.last, article: article)
    end
    redirect 'articles'
  end

  get '/:id' do
    @comments = Comment.find(article_id: params[:id])
    slim :'comments/show'
  end
end

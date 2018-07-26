require_relative '../models/article.rb'
require_relative '../dao/article_dao.rb'

class ApplicationController < Sinatra::Base
  set :views, File.expand_path(File.join(__FILE__, '../../views'))
  get '/' do
    article_dao = DAO::ArticleDAO.new(Redis.new)
    @article_list = article_dao.select_all
    slim :'/index'
  end

  post '/' do
    article_dao = DAO::ArticleDAO.new(Redis.new)
    # Exception control
    article = Models::Article.new(1, 'Артикл 1', params[:link], [Models::Comment.new(1, 'First', 3), Models::Comment.new(2, 'Second', 2), Models::Comment.new(3, 'Third', 1)])
    # Parse data from parser /\
    article_dao.save(article)
    @article_list = article_dao.select_all
    slim :'/index'
  end
end

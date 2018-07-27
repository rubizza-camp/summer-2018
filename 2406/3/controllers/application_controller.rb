require_relative '../models/article.rb'
require_relative '../dao/article_dao.rb'
require_relative '../parsers/html_parser/html_parser.rb'
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
    article_dao.save(HTMLParser.to_article(params[:link]))
    @article_list = article_dao.select_all
    slim :'/index'
  end
end

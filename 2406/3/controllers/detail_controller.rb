require_relative '../models/article.rb'
require_relative '../models/comment.rb'

class DetailController < Sinatra::Base
  set :views, File.expand_path(File.join(__FILE__, '../../views'))
  get '/:id' do
    @article = Models::Article.new(0, 'kek','http://vk.com', [Models::Comment.new('Name comment 1', 'Description comment 1', 1), Models::Comment.new('Name comment 2', 'Description comment 2', 2), Models::Comment.new('Name comment 3', 'Description comment 3', 3)])#DAO::ArticleDAO.select_by_id(params[:id])
    slim :'/detail_article'
  end

  post '/:id' do
    #@article = Models::Article.new # Load form DB
    slim :'/detail_article'
  end
end

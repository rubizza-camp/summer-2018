require_relative '../models/article.rb'
require_relative '../models/comment.rb'

class DetailController < Sinatra::Base
  set :views, File.expand_path(File.join(__FILE__, '../../views'))

  get '/:id' do
    article_dao = DAO::ArticleDAO.new(Redis.new)
    @article = article_dao.select_by_id(params[:id])
    slim :'/detail_article'
  end
end

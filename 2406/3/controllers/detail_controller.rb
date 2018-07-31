require_relative '../models/article.rb'
require_relative '../models/comment.rb'

class DetailController < Sinatra::Base
  set :views, File.expand_path(File.join(__FILE__, '../../views'))

  get '/:id' do
    @article = Repository::Article.new(Redis.new).select_by_id(params[:id])
    slim :'/detail_article'
  end
end

require_relative '../models/article.rb'
require_relative '../repository/article.rb'
require_relative '../parsers/html_parser.rb'
require_relative '../validators/input_validators'

require 'uri'
require 'net/https'

class ApplicationController < Sinatra::Base
  set :views, File.expand_path(File.join(__FILE__, '../../views'))
  get '/' do
    article_repository = Repository::Article.new(Redis.new)
    @article_list = article_repository.select_all
    slim :'/index'
  end

  post '/' do
    article_repository = Repository::Article.new(Redis.new)
    tmp_buffer = article_repository.select_all
    begin
      checker = Validators::InputValidators.new
      checker.exist(tmp_buffer, params[:link])
      checker.invalid_link(params[:link])
      article_repository.save(HTMLParser.to_article(params[:link]))
      @article_list = article_repository.select_all
      slim :'/index'
    rescue ArgumentError
      redirect '/errors/'
    end
  end
end

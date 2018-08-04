require 'sinatra'
require 'ohm'
require 'mechanize'
require 'sass'
require 'sinatra/asset_pipeline'
require 'sinatra/static_assets'
require 'json'
require 'open-uri'
require 'net/https'
require 'uri'
require_relative './helpers/helpers'

class ApplicationController < Sinatra::Base
  set :root, File.dirname(__FILE__)
  set :assets_precompile, %w[*.css]
  set :assets_paths, ['assets/stylesheets']
  set :assets_css_compressor, :sass

  register Sinatra::AssetPipeline

  get '/' do
    error_text = ''
    erb :index, locals: { error_text: error_text }
  end

  post '/' do
    error_text = LinkVerificator.new(params['address']).check_link
    RecordMaker.new(params['address']).make_record if error_text == ''
    erb :index, locals: { error_text: error_text }
  end

  post '/posts/articles' do
    articles = Article.all.to_a
    erb :'posts/articles', locals: { articles: articles }
  end

  get '/posts/comments/:id' do
    @comments = Comment.all.to_a.select { |comment| comment.article_id == params[:id] }
    erb :'posts/comments'
  end
end

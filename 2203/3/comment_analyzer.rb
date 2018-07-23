require 'bundler'
Bundler.require

require 'json'
require 'haml'
require 'mechanize'
require 'ohm'
require 'redis'
require 'sass'
require 'sinatra'
require 'sinatra/asset_pipeline'
require 'sinatra/static_assets'

# Prepare assets to application
class CommentAnalyzer < Sinatra::Base
  set :root, File.dirname(__FILE__)

  set :assets_precompile, %w(*.css *.png *.jpg *.svg)
  set :assets_paths, ['assets/stylesheets', 'assets/images']
  set :assets_css_compressor, :sass

  register Sinatra::AssetPipeline

  def image_tag(path)
    "<img src=\"#{image_path(path)}\"/>"
  end

  get '/' do
    haml :index
  end
end

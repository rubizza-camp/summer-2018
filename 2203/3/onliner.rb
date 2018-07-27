require 'sinatra'
require 'ohm'
require 'haml'
require 'mechanize'
require 'sass'
require 'sinatra/asset_pipeline'
require 'sinatra/static_assets'
require 'json'
require 'open-uri'
require 'net/https'
require 'uri'

Dir.glob('./{controllers,helpers}/*.rb').each { |path| require path }

# Initialize base sinatra class
class Onliner < Sinatra::Base
  set :root, File.dirname(__FILE__)
  set :assets_precompile, %w[*.css]
  set :assets_paths, ['assets/stylesheets']
  set :assets_css_compressor, :sass

  register Sinatra::AssetPipeline

  get '/' do
    error_text = ''
    haml :index, locals: { error_text: error_text }
  end

  post '/' do
    error_text = LinkVerificator.new(params['address']).check_link
    RecordMaker.new(params['address']).make_record if error_text == ''
    haml :index, locals: { error_text: error_text }
  end

  post '/posts/posts' do
    posts = Post.all.to_a
    haml :'posts/posts', locals: { posts: posts }
  end

  get '/posts/comments/:id' do
    @comments = Comment.all.to_a.select { |comment| comment.post_id == params[:id] }
    haml :'posts/comments'
  end
end

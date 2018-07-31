require 'bundler'
Bundler.require(:default)

use Rack::MethodOverride
Dir.glob('./{helpers,controllers,models}/*.rb').each { |file| require file }
Article.redis = Redic.new('redis://127.0.0.1:6379')
Comment.redis = Redic.new('redis://127.0.0.1:6379')

map('/articles') { run ArticlesController }


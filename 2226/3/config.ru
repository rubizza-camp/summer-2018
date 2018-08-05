Bundler.require(:default, :development)

Dir.glob('./{models,helpers,controllers}/*.rb').each { |file| require file }

Article.redis = Redic.new('redis://127.0.0.1:6379/0')
Comment.redis = Redic.new('redis://127.0.0.1:6379/1')

use Rack::MethodOverride

map('/') { run ApplicationController }

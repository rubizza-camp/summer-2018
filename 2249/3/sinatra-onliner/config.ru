# frozen_string_literal: true

Bundler.require(:development)
Dir.glob('./{controllers,services,models}/*.rb').sort.each { |file| require file }
Post.redis = Redic.new('redis://127.0.0.1:6379/0')
Comment.redis = Redic.new('redis://127.0.0.1:6379/1')

use Rack::MethodOverride
map('/') { run PostsController }

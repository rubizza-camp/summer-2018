require 'sinatra/base'
require 'sidekiq/api'
require 'sidekiq/web'
require 'ohm'

Dir.glob('./{controllers,helpers,models}/*.rb').sort.each do |file|
  require file
end
require './lib/workers/post_worker'
Post.redis    = Redic.new('redis://127.0.0.1:6379/0')
Comment.redis = Redic.new('redis://127.0.0.1:6379/1')

map('/posts') { run PostsController }
map('/sidekiq') { run Sidekiq::Web }
map('/') { run ApplicationController }

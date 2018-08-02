require 'sinatra/base'
#require './controllers/application_controller'
#require './controllers/users_controller'
require 'ohm'
Dir.glob('./app/{helpers,controllers,models}/*.rb').each { |file| require_relative file }

map('/') {run ApplicationController}
map('/articles') {run ArticlesController}

Article.redis = Redic.new('redis://127.0.0.1:6379')
Comment.redis = Redic.new('redis://127.0.0.1:6379')

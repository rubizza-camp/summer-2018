require 'bundler'
Bundler.require

Dir.glob('./{models,controllers,helpers}/*.rb').each { |file| require_relative file }

Article.redis = Redic.new('redis://127.0.0.1:6379/0')
Comment.redis = Redic.new('redis://127.0.0.1:6379/0')

map('/articles') { run ArticlesController }
map('/') { run ApplicationController }

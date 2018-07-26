# frozen_string_literal: true

require 'bundler'
Bundler.require(:development)

Dir.glob('./{controllers,models,helpers}/*.rb').each { |file| require file }
Article.redis = Redic.new('redis://127.0.0.1:6379/0')
Comment.redis = Redic.new('redis://127.0.0.1:6379/1')

map('/') { run ArticlesController }

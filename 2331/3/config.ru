require 'bundler'
Bundler.require

Dir.glob('./{controllers,helpers,models}/*.rb').each { |file| require_relative file }

map('/articles') { run ArticlesController }
map('/') { run ApplicationController }

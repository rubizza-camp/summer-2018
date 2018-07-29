require 'bundler'
Bundler.require

Dir.glob('./{controllers,lib,models}/*.rb').each { |file| require file }

map('/posts') { run PostsController }
map('/') { run ApplicationController }

require 'bundler'
Bundler.require

Dir.glob('./{helpers,controllers,models}/*.rb').each { |file| require file }

map('/articles') { run ArticlesController }


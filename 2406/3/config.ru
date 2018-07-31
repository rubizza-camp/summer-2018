require 'sinatra/base'
require 'slim'
require 'sass'
require 'redis'
require 'json'
require 'mechanize'
require 'pry'

# Dir.glob('./{analyzer, controllers, hash_serializer, models, parsers, repository, validators}/*.rb').each { |file| require_relative file }
Dir["./**/*.rb"].each { |file| load(file) }
map('/') { run ApplicationController }
map('/articles/') { run DetailController }
map('/errors/') { run ErrorController }

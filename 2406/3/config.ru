require 'sinatra/base'
require 'slim'
require 'sass'
require 'redis'
require 'json'
require 'mechanize'

Dir.glob('./{controllers, dao, models}/*.rb').each { |file| require_relative file }
map('/') { run ApplicationController }
map('/articles/') { run DetailController }

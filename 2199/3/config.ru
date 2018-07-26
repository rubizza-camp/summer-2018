require 'sinatra/base'
require_relative 'app/onliner_page_parser'
require_relative 'controllers/application_controller'

#Dir.glob('./{helpers, controllers}/*.rb').each { |file| require file }
map('/') { run ApplicationController }

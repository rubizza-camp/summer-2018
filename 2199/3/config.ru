require 'sinatra/base'
require 'ohm'
require_relative 'app/onliner_page_parser'
require_relative 'app/comment_analyzer'
require_relative 'controllers/application_controller'
require_relative 'models/page'
require_relative 'models/comment'

# Dir.glob('./{helpers, controllers}/*.rb').each { |file| require file }
map('/') { run ApplicationController }

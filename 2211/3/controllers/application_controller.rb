require_relative 'models/LinkFilling'
require_relative 'models/Parser'
require_relative 'models/PostQuere'

# controller for application

class ApplicationController < Sinatra::Base
  set :views, File.expand_path(File.join(__FILE__, '../../views'))
end

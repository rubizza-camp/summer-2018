require 'sinatra/config_file'

# controller for application

class ApplicationController < Sinatra::Base
  set :views, File.expand_path(File.join(__FILE__, '../../views'))
  register Sinatra::ConfigFile
  config_file '../config.yml'
end

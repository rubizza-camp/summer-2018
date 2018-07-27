# frozen_string_literal: true

require 'sinatra/config_file'

# Main controller
class ApplicationController < Sinatra::Base
  set :views, File.expand_path(File.join(__FILE__, '../../views'))
  register Sinatra::ConfigFile
  config_file '../config.yml'
end

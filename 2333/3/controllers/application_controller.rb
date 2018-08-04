# frozen_string_literal: true

require 'erb'
require 'sinatra/config_file'

# application controller
class ApplicationController < Sinatra::Base
  set :views, File.expand_path(File.join(__FILE__, '../../views'))
  register Sinatra::ConfigFile
  config_file '../config.yml'
end

require 'sinatra/config_file'

class ApplicationController < Sinatra::Base
  set :views, File.expand_path(File.join(__FILE__, '../../views'))
  register Sinatra::ConfigFile
  config_file '../../config.yml'

  get '/' do
    slim :'index'
  end
end

require 'sinatra/config_file'

class ApplicationController < Sinatra::Base
  set :views, Proc.new { File.join(root, "../views") }
  register Sinatra::ConfigFile
  config_file '../../config.yml'

  get '/' do
    slim :'index'
  end
end

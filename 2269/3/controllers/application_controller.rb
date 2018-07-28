# Class
class ApplicationController < Sinatra::Base
  set :views, File.expand_path(File.join(__FILE__, '../../views'))
  set :method_override, true

  get '/' do
    redirect '/articles'
  end
end

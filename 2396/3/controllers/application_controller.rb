# This class is the base for my controllers
class ApplicationController < Sinatra::Base
  set :views, File.expand_path(File.join(__FILE__, '../../views'))
  not_found do
    erb :not_found, layout: false
  end

  get '/' do
    redirect '/posts'
  end
end

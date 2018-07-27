# Default class to start Sinatra
class ApplicationController < Sinatra::Base
  set :views, File.expand_path(File.join(__FILE__, '../../views'))
  set :method_override, true

  get '/' do
    redirect to '/articles'
  end

  not_found do
    erb :not_found
  end
end

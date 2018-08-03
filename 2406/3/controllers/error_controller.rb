class ErrorController < Sinatra::Base
  set :views, File.expand_path(File.join(__FILE__, '../../views'))

  get '/' do
    slim :'/error_page'
  end
end

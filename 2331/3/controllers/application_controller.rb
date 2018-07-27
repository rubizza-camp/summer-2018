class ApplicationController < Sinatra::Base
  set :views, File.expand_path(File.join(__FILE__, '../../views'))
  set :method_override, true

  not_found do
    erb :not_found
  end

  get '/' do
    redirect to '/articles'
  end
end

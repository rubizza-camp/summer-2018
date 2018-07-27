class ApplicationController < Sinatra::Base
  set :views, File.expand_path('../views', __dir__)
  not_found do
    slim :not_found
  end
end

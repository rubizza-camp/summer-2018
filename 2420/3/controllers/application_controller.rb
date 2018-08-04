# class ApplicationController
class ApplicationController < Sinatra::Base
  helpers ApplicationHelper

  configure do
    set :views, './views/'
    set :root, File.expand_path('..', __dir__)
  end

  get '/' do
    title 'My App'
    erb :table
  end
end

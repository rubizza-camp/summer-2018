class ApplicationController < Sinatra::Base
  helpers ApplicationHelper

  set :views, File.expand_path('../../views', __dir__)

  # don't enable logging when running tests
  configure :production, :development do
    enable :logging
  end
end

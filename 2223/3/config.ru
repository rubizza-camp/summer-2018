require 'sinatra/base'

Dir.glob('./app/{helpers,controllers,models}/*.rb').each { |file| require file }

map('/') { run ArticlesController }

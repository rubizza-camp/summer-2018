require 'sinatra/base'

Dir.glob('./{helpers,controllers,views}/*.rb').each { |file| require file }

map('/') { run ApplicationController }

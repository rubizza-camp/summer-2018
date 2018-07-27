require 'bundler'
require 'sinatra'
Bundler.require(:default)

use Rack::MethodOverride
Dir.glob('./{helpers,controllers,models}/*.rb').each { |file| require file }

run Sinatra::Application.run!
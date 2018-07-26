require 'sinatra'
require 'erb'

# application controller
class ApplicationController < Sinatra::Base
  set :views, File.expand_path(File.join(__FILE__, '../../views'))
end

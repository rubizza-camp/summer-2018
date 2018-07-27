require 'sinatra'
class ApplicationController < Sinatra::Base
  set :views, File.expand_path(File.join(__FILE__, '../../views'))
  set :public_folder, File.expand_path(File.join(__FILE__, '../../assets'))
end
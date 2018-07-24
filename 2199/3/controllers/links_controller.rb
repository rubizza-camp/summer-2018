require 'sinatra'
# links controller
class LinksController < ApplicationController
  get '/' do
    'index'
  end
end
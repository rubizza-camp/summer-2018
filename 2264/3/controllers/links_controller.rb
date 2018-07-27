require 'sinatra'

class LinksController < ApplicationController
get '/links' do
  @links = Link.all
  
end

get '/links/new' do
  erb :'link/new'
end
end
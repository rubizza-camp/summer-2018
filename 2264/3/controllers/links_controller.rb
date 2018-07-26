require 'sinatra'

get '/' do
  erb :index
end

get '/new' do
  erb :new
end


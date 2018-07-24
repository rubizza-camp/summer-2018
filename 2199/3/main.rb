require 'sinatra'
require 'redis'
require 'ohm'
require 'pry'

#Ohm.redis = Redis.new('redis://127.0.0.1:6379')
get '/' do
  #Ohm.redis.call 'SET', 'Foo', 'Bar'

  #Ohm.redis.call 'GET', 'Foo'
  erb :index
end
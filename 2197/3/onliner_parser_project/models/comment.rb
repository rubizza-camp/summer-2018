require 'ohm'
require 'sinatra'

class Comment < Ohm::Model
	attribute :content # It's automaticly, isn't it?
	attribute :rating
end
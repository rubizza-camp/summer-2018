require 'ohm'
require 'sinatra'

class Article < Ohm::Model
	attribute :link
	set :comments, :Comment
	attribute :rating
end
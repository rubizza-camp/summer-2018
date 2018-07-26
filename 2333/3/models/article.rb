require 'ohm'
require_relative 'comment.rb'

# article model for ohm
class Article < Ohm::Model
  attribute :link
  attribute :rating
  set :comments, :Comment
end

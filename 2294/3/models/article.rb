require_relative 'comment.rb'

class Article < Ohm::Model
  attribute :link
  attribute :rating
  set :comments, :Comment
end

require 'ohm'
class Article < Ohm::Model
  attribute :link
  attribute :rating
  set :comments, :Comment
end
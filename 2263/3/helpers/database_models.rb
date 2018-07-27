require 'ohm'

class Comment < Ohm::Model
  attribute :body
  attribute :sentiment
end

class Article < Ohm::Model
  list :comments, :Comment
  attribute :link
  attribute :sentiment
end

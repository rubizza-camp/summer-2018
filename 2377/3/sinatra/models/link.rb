require 'ohm'
# Describes link
class Link < Ohm::Model
  attribute :link
  list :comments, :Comment
  attribute :score
end

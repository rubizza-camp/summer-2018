require 'ohm'
# Link
class Link < Ohm::Model
  attribute :address
  attribute :rate
  list :comments, :Comment
end

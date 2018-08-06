require 'ohm'

class Rating < Ohm::Model
  attribute :value
  reference :comment, :Comment
end

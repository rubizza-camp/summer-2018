require "ohm"
class Comment < Ohm::Model
  attribute :text
  attribute :author
  attribute :rating
end
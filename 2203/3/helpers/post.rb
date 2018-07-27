# Basic class to add Ohm models
class Post < Ohm::Model
  attribute :link
  attribute :rating
  collection :comment, :Comment
end

# Post model
class Post < Ohm::Model
  attribute :link
  attribute :title
  attribute :rating
  unique :link
  collection :comments, :Comment
end

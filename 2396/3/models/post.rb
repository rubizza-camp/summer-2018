# This is model post
class Post < Ohm::Model
  attribute :title
  attribute :link
  attribute :rating
  set :comments, Comment
end

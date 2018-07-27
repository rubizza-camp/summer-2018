# class for onliner posts
class Post < Ohm::Model
  attribute :link
  attribute :title
  set :comments, :Comment
  attribute :rating
end

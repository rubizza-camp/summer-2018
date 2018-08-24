# Model for Article
class Article < Ohm::Model
  attribute :link
  attribute :title
  attribute :rating
  set :comments, :Comment
end

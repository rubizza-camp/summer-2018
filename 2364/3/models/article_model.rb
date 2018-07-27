# Model for artical
class Article < Ohm::Model
  attribute :link
  attribute :title
  set :comments, :Comment
  attribute :rating
end

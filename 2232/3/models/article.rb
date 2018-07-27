class Article < Ohm::Model
  attribute :title
  attribute :link
  attribute :rating
  set :comments, :Comment
end

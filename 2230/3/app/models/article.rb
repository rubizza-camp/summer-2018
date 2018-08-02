class Article < Ohm::Model
  attribute :url
  attribute :title
  attribute :rating
  collection :comments, :Comment
end

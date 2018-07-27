class Comment < Ohm::Model
  attribute :text
  attribute :rating
  collection :post, :Post
end

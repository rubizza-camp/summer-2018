# Comment model
class Comment < Ohm::Model
  attribute :author
  attribute :text
  attribute :rating
  reference :post, :Post
end

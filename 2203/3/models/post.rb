class Post < Ohm::Model
  attribute :link
  attribute :post_rating
  collection :comment, :Comment
end

class Comment < Ohm::Model
  attribute :text
  attribute :rating
  reference :article, :Article
end

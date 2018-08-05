class Comment < Ohm::Model
  attribute :author
  attribute :text
  attribute :rating
  reference :article, :Article
end

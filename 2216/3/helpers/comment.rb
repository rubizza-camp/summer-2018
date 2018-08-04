class Comment < Ohm::Model
  attribute :comment_text
  attribute :score
  reference :article, :Article
end

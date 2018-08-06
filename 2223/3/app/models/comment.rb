require 'ohm'

class Comment < Ohm::Model
  attribute :text
  reference :article, :Article
  reference :rating, :Rating
end

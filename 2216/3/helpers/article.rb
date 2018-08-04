class Article < Ohm::Model
  attribute :link
  attribute :score
  collection :comment, :Comment
end

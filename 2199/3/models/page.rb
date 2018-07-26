class Page < Ohm::Model
  attribute :title
  collection :comments, Comment
end
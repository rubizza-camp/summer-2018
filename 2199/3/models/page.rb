class Page < Ohm::Model
  attribute :link
  collection :comments, 'Comment'
  index :link

  def rating
    comments.sum { |comment| comment.rating.to_f } / comments.count
  end
end
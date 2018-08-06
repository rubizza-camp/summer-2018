require 'ohm'

class Article < Ohm::Model
  attribute :name
  collection :comments, :Comment

  def rating
    @rating ||= rating_calculation
  end

  private

  def rating_calculation
    total = comments.sum { |comment| comment.rating.value.to_f }
    (total / comments.size).round
  end
end

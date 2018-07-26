class Comment
  attr_reader :text, :rating
  def initialize(text, rating)
    @text = text
    @rating = rating
  end
end

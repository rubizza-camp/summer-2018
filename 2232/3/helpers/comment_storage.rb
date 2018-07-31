class CommentStorage
  attr_reader :text, :rating, :author

  def initialize(author, text, rating)
    @author = author
    @text = text
    @rating = rating
  end
end

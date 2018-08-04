# Comment class
class Comment
  attr_reader :comment, :sentiment

  def initialize(comment, sentiment = 0.5)
    @comment = comment
    @sentiment = transform_sentiment(sentiment)
  end

  private

  def transform_sentiment(sentiment)
    sentiment * 200 - 100
  end
end

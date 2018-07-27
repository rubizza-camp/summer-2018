class Comment
  attr_reader :comment, :sentiment

  def initialize(comment, sentiment)
    @comment = comment
    @sentiment = transform_sentiment(sentiment)
  end

  def good?
    @sentiment >= 0 ? true : false
  end

  private

  def transform_sentiment(sentiment)
    sentiment * 200 - 100
  end
end

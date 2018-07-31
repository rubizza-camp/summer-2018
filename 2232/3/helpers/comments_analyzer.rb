require_relative 'sentiment_parser'
require_relative 'comment_storage'

class CommentsAnalyzer
  def initialize(comments)
    @comments = comments
  end

  def analyze
    sentiments.map do |sentiment|
      author_text = @comments[sentiment['id'].to_i]
      CommentStorage.new(author_text[0], author_text[1], rating_recount(sentiment['score']))
    end
  end

  private

  # transfer rating from natural range to integer
  def rating_recount(score)
    (score * 200 - 100).to_i
  end

  def sentiments
    SentimentParser.new(@comments).call
  end
end

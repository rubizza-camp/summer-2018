class CommentsRating
  LIMIT = 50

  def initialize(comments)
    @comments = comments
  end

  # :reek:FeatureEnvy
  def put_ratings
    selected_for_evaluation = sort_comments_by_votes
    ratings = RatingCounter.new(selected_for_evaluation).calculate
    selected_for_evaluation.zip(ratings).map do |record|
      record.first[:rating] = record.last
      record[0]
    end
  end

  private

  def sort_comments_by_votes
    @comments.sort_by { |comment| comment[:votes] }.reverse.first(LIMIT)
  end
end

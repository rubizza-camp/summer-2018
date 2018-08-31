# this class returns comments with ratings
class CommentsReferee
  attr_reader :comments, :ratings
  def initialize(comments_arr)
    @comments = comments_arr
    sort_comments_by_votes
    @ratings = RatingCounter.new(comments).comments_ratings
  end

  # :reek:FeatureEnvy
  def put_ratings
    comments.zip(ratings).map do |record|
      record.first[:rating] = record.last
      record[0]
    end
  end

  private

  def sort_comments_by_votes
    comments.sort_by { |comment| comment[:votes] }.reverse
  end
end

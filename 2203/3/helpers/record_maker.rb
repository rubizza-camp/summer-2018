class RecordMaker
  attr_reader :url

  def initialize(url)
    @url = url
  end

  def make_record
    comments = fetch_comments
    rating = Rating.new(TextAnalyticsApi.new(comments).score, comments)
    article = Post.create link: url, rating: rating.post_rating
    make_comments_link(comments, article, rating)
  end

  private

  def fetch_comments
    ArticleParser.new(url).parse
  end

  def make_comments_link(comments, article, rating)
    comments.each do |comment|
      Comment.create comment_text: comment, rating: rating.comment_score(comment), post: post
    end
  end
end

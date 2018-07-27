# This is helper for create post from comments
class CreatePost
  attr_reader :link
  def initialize(link)
    @link = link
  end

  def perform
    create
  end

  private

  def create
    comments = CommentsParser.new.perform(link)
    rating   = RatingCounter.new.perform(comments)
    post     = Post.create title: fetch_title, link: link,
                           rating: rating.sum / rating.size
    create_comments_for_post(post, comments, rating)
  end

  def fetch_title
    CommentsParser.fetch_title(link)
  end

  def create_comments_for_post(post, comments, rating)
    comments.zip(rating).each do |obj|
      post.comments.add(Comment.create(text: obj.first, rating: obj.last))
    end
  end
end

# this class creates a post
class PostBuilder
  attr_reader :post_link, :comments, :post

  def initialize(options)
    @post_link = options[:post]
    @comments = PostParser.new(post_link).comments
  end

  def create
    @post = Post.create(link: post_link, title: title, rating: post_rating)
    CommentsBuilder.new(comments_with_rating, post).create
    post
  end

  private

  def post_rating
    comments_with_rating.map { |comment| comment[:rating] }.sum / comments.size
  end

  def comments_with_rating
    CommentsReferee.new(comments).put_ratings
  end

  def title
    PostParser.new(post_link).title
  end
end

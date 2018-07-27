class PostAnalyser
  attr_reader :post, :text_body, :ratings

  def initialize(post)
    @post = post
    @text_body = launch_comments_parser
    @ratings = launch_rating_counter
  end

  def launch
    refresh_post_title
    build_post_stat
    refresh_post_rating
  end

  private

  def launch_comments_parser
    CommentsParser.new(post.link).launch_parser
  end

  def launch_rating_counter
    CommentRatingCounter.new(text_body).launch_counter
  end

  def refresh_post_title
    page = Mechanize.new.get(post.link)
    @post.update(title: page.title)
  end

  def build_post_stat
    text_body.each_with_index do |text, index|
      comment = Comment.create(text: text, rating: ratings[index])
      post.comments.add(comment)
    end
  end

  def refresh_post_rating
    post_rating = (ratings.sum / text_body.size).to_i
    @post.update(rating: post_rating)
  end
end
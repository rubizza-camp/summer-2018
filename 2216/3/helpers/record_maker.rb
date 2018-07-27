class RecordMaker
  attr_reader :url

  def initialize(url)
    @url = url
  end

  def make_record
    comments = fetch_comments
    score = Rating.new(AzureTextAnalytics.new(comments).pull_out_score, comments)
    article = Article.create link: url, score: score.article_score
    make_comments_link(comments, article, score)
  end

  private

  def fetch_comments
    ArticleParser.new(url).parse
  end

  def make_comments_link(comments, article, score)
    comments.each do |comment|
      Comment.create comment_text: comment, score: score.comment_score(comment), article: article
    end
  end
end

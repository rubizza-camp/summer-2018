class UploadArticle
  def self.call(link)
    new(link).call
  end

  attr_reader :parser

  def initialize(link)
    @parser = ArticleParser.new(link)
  end

  def call
    load_comments
    article
  end

  private

  def article
    @article ||= Article.create(name: parser.title)
  end

  def load_comments
    text_evaluation.each do |text, evaluation|
      rating = Rating.create(value: evaluation)
      Comment.create(text: text, article: article, rating: rating)
    end
  end

  def text_evaluation
    Azure.new(parser.comments).texts_evaluation
  end
end

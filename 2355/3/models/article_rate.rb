require_relative './text_analytics.rb'
require_relative './article.rb'

# This class is needed to get article rate
class ArticleRate
  attr_reader :rate, :article

  def initialize(url)
    @rate = 0
    @article = Article.new(url)
  end

  def all_comments_rate
    docs = []
    @article.comments.each do |comment|
      docs << { 'id' => 1, 'language' => 'ru', 'text' => comment.text.to_s }
    end
    documents = { 'documents': docs }
    TextAnalytics.new(documents).analyze['documents']
  end

  def article_rate
    comments_rate = all_comments_rate
    comments_rate.each do |comment|
      @rate += ((comment['score'] * 200) - 100)
    end
    @rate /= comments_rate.size
  end
end

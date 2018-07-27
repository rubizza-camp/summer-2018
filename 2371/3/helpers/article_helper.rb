require_relative 'helper'
class ArticleHelper < Helper
  attr_accessor :id, :link, :comments

  def to_json(_options)
    { id: id, url: url, comments: comments.to_json }.to_json
  end

  # def add_comments(comments_json)
  #   comments_json.each { |comment| comments << CommentHelper.new(comment) }
  # end

  def add_comments_score(scores)
    scores.each do |score|
      comments.detect do |comment|
        comment.id == score['id'].to_i
      end.rating = score['score']
    end

  end

  def azure_document
    { 'documents': comments.map(&:comment_to_azure_data) }
  end

  def rating
    comments.map(&:rating).reduce(:+) / comments.size
  end

end
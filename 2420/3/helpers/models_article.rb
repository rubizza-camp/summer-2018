require 'ohm'
# class Article
class Article < Ohm::Model
  list :comments, :Comment
  attribute :article_rating
  attribute :url
end
# class Comment
class Comment < Ohm::Model
  attribute :body
  attribute :comment_rating
end

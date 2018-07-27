require 'ohm'

# Comment redis model, has comment itself and it's sentiment
class CommentDB < Ohm::Model
  attribute :body
  attribute :sentiment
end

# Article redis model, has link to the article, list of comments and everage sentiment of all comments
class Article < Ohm::Model
  list :comments, :CommentDB
  attribute :link
  attribute :sentiment
end

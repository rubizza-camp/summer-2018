require 'ohm'

# Comment redis model, has comment itself and it's sentiment
class CommentModel < Ohm::Model
  attribute :body
  attribute :sentiment
end

# Article redis model, has link to the article, list of comments and everage sentiment of all comments
class ArticleModel < Ohm::Model
  list :comments, :CommentModel
  attribute :link
  attribute :sentiment
end

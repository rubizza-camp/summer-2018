# Class that represents model of Article
class Article < Ohm::Model
  attribute :url
  attribute :title
  set :comments, :Comment
  attribute :rating
end

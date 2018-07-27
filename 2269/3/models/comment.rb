# Class that represents model of Comment to a Article
class Comment < Ohm::Model
  attribute :content
  attribute :rate
end

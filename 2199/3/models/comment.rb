# Comment model
class Comment < Ohm::Model
  attribute :text
  attribute :rating
  reference :page, 'Page'
end

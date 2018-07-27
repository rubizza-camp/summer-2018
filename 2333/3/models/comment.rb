# frozen_string_literal: true

# comment model for ohm
class Comment < Ohm::Model
  attribute :text
  attribute :rating
end

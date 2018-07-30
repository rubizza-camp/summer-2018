# frozen_string_literal: true

# class model Comment

class Comment < Ohm::Model
  attribute :text
  attribute :rating
end

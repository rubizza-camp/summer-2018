# frozen_string_literal: true

# class model Post

class Post < Ohm::Model
  attribute :link
  set :comments, Comment
  attribute :rating
end

require_relative 'helper'
class CommentHelper < Helper
  attr_accessor :id, :text, :author, :rating

  def to_json(_options)
    { id: id, text: text, author: author, rating: rating }.to_json
  end

  def comment_to_azure_data
    { 'id': id, 'language': 'ru', 'text': text }
  end
end
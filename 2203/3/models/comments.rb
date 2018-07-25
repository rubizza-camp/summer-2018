require './parser.rb'

# This class extracts comments from json
class Comments
  attr_reader :link, :comments_list

  def initialize(link)
    @link = link
    @comments_list = search_comments
  end

  private

  def search_comments
    Parser.new(link).json['comments'].map { |comment| comment['text'] }
  end
end

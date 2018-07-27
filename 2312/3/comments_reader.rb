require './onliner_parser'
# This class extracts comments from json
class CommentsReader
  attr_reader :link, :comments_list
  def initialize(link)
    @link = link
    @comments_list = search_comments
  end
  private
  def search_comments
    OnlinerParser.new(link).json['comments'].map { |comment| comment['text'] }
  end
end

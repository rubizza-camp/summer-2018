require_relative './comment_parser.rb'

# This class describes article
class Article
  attr_reader :url, :comments

  def initialize(url)
    @url = url
    parser = CommentParser.new
    parser.parse(url)
    @comments = parser.comments
  end
end

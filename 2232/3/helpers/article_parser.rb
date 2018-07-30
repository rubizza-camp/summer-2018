require_relative 'comments_parser'
require_relative 'comments_analyzer'

class ArticleParser
  attr_reader :link

  def initialize(link)
    @link = link
  end

  def title
    page.title
  end

  def rating
    comments.map(&:rating).reduce(:+) / comments.size
  end

  def comments
    untreated_comments = CommentsParser.new(page, link).comments
    @comments ||= CommentsAnalyzer.new(untreated_comments).analyze
  end

  private

  def page
    @page ||= Mechanize.new.get(link)
  end
end

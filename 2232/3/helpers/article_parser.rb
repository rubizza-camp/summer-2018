require_relative 'comments_parser'

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
    @comments ||= CommentsParser.new(page, link).call
  end

  private

  def page
    @page ||= Mechanize.new.get(link)
  end
end

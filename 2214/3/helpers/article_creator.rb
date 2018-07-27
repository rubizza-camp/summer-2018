require_relative 'comments_creator'
require_relative 'specific_comment'

class ArticleCreator
  def initialize(link)
    @link = link
  end

  def rating
    comments.map { |comment| comment.rating }.reduce(:+) / comments.size
  end

  def comments
    @comments ||= CommentsCreator.new(@link).create
  end
end

puts ArticleCreator.new('https://people.onliner.by/opinions/2018/07/13/o-gendernom-ravenstve').rating

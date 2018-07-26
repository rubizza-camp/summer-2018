require_relative 'comments_creator'
require_relative 'comment'
require 'bundler'
Bundler.require

class Article
  def initialize(link)
    @link = link
  end

  def rating
    puts comments.map(&:rating).reduce(:+) / comments.size
  end

  def comments
    @comments ||= CommentsCreator.new(@link).create
  end
end

Article.new('https://people.onliner.by/opinions/2018/07/24/mnenie-957').rating

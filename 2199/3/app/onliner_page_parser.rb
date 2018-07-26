require 'pry'
require_relative '../app/comment_parser'
require_relative 'capybara_initializer'

# class for parsing
class OnlinerPageParser
  COMMENTS_TO_TAKE = 50

  def initialize(link)
    @link = link
  end

  def browser
    @browser ||= Capybara.current_session
  end

  def top_comment_texts
    browser.visit(@link)
    binding.pry
    browser.find('.news-comment__all-button_visible').click
    top_comments.map(&:text)
  end

  def comment_nodes
    browser.all('.news-comment__unit').drop(1)
  end

  def comments
    comment_nodes.map { |comment_node| CommentParser.new(comment_node) }
  end

  def top_comments
    comments.sort_by(&:rating).reverse.first(COMMENTS_TO_TAKE)
  end
end

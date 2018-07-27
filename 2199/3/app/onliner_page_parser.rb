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

  def visit_page
    attempts = 0
    begin
      browser.visit(@link)
    rescue StandardError => e
      attempts += 1
      sleep(2 * attempts)
      if attempts <= 3
        retry
      else
        raise e
      end
    end
  end

  def show_all_comments
    browser.find('.news-form__control_condensed .news-form__button').click
    sleep(5)
  end

  def top_comment_texts
    visit_page
    show_all_comments
    top_comments.map(&:text)
  end

  def comment_nodes
    browser.all('[id^="comment-"]').drop(1)
  end

  def comments
    comment_nodes.map { |comment_node| CommentParser.new(comment_node) }
  end

  def top_comments
    comments.sort_by(&:rating).reverse.first(COMMENTS_TO_TAKE)
  end
end

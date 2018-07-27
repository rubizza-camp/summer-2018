require 'selenium-webdriver'

# This class parse web page for comments
class CommentParser
  attr_reader :comments

  def initialize
    @comments = []
    @driver = Selenium::WebDriver.for :chrome
  end

  def parse(url)
    @driver.get url
    begin
      @driver.find_element(:class, 'news-form__button').click
    ensure
      @comments = @driver.find_elements(:class, 'news-comment__speech')
    end
  end
end

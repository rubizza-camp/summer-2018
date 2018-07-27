require 'capybara'

Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end
# :reek:FeatureEnvy
# rubocop:disable Metrics/LineLength
class Pars
  attr_reader :link

  def initialize(link)
    @link = link
  end

  def comments
    session = Capybara::Session.new(:selenium)
    session.visit(link)
    session.find('a.button-style.button-style_subsidiary.button-style_big.news-form__button.news-form__button_width_full.news-form__button_font-weight_semibold').click
    session.find_by_id('comments')
           .all('.news-comment__speech.news-comment__speech_base' || '.news-comment__unit')
           .first(20)
           .map(&:text)
  end
end
# rubocop:enable Metrics/LineLength

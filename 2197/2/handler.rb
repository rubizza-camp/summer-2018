require_relative 'helper'
require_relative 'constants'

# Class for working with Battles and Artist class
class Handler
  include Helper
  attr_reader :rappers
  def initialize
    @rappers = battlers
  end

  def sort_top_rappers(number)
    rappers.values.sort_by { |item| - item.count_bad_words }.first(number)
  end

  private

  def find_artist_by_name(file_name)
    rappers.class.equal?(Hash)
    file_name.split(REGEX_FOR_NAMES) \
             .first.split('/').last.strip
  end
end

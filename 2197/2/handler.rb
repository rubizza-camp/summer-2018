require_relative 'service'

REGEX_FOR_NAMES = /#|против|vs|VS|aka/

# Class for working with Battles and Artist class
class Handler
  attr_reader :rappers
  def initialize
    @rappers = Service.new.battlers
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

require 'pry'
require_relative 'raper.rb'

# Class table row, show rating
class TableRow
  attr_reader :row
  def initialize(raper)
    @raper = raper
  end

  def row
    @row = ["#{@raper.name}", "#{@raper.sum_battles} батлов", "#{@raper.bad_words} нецензурных слов",
            "#{@raper.bad_words_in_battle} слова на баттл", "#{@raper.words_in_raund} слова в раунде"]
  end
end

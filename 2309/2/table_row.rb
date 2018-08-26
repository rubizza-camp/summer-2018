require 'pry'
require_relative 'raper.rb'

# Class table row, show rating
class TableRow
  def initialize(raper)
    @raper = raper
  end

  def row
    @row = [@raper.name.to_s, @raper.sum_battles.to_s + ' батлов', @raper.bad_words.to_s + ' нецензурных слов',
            @raper.bad_words_in_battle.to_s + ' слова на баттл', @raper.words_in_raund.to_s + ' слова в раунде']
  end
end

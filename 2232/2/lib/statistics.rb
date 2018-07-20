require_relative 'helpers/battles_helper'

class Statistics
  include BattlesHelper

  BATTLE_HEADINGS = ['Battler', 'Number of battles', 'Number of curses', 'Curses in battle', 'Words in part'].freeze
  WORD_HEADINGS = ['Battler', 'Top words'].freeze

  def find_top_battlers(count)
    battlers = top_battlers
    tabular_output(battlers[0...count], BATTLE_HEADINGS)
  end

  def find_top_words(name, count)
    words = top_words(name)
    tabular_output(words[0...count], WORD_HEADINGS) unless words.empty?
  end
end

require_relative 'work_with_dir'
require_relative 'work_with_battles'
# require 'terminal-table'

class LevelManager
  def self.find_top_battlers(count)
    list_battlers = WorkWithDir.take_all_battles.map { |el| WorkWithBattles.out_name_bat(el) }.uniq
    battlers = WorkWithBattles.top_battlers(list_battlers)
    headings = ['Battler', 'Number of battles', 'Number of curses', 'Curses in battle', 'Words in part']
    WorkWithBattles.tabular_output(battlers[0...count], headings)
  end

  def self.find_top_words(name_bat, count)
    words = WorkWithBattles.top_words(name_bat)
    WorkWithBattles.tabular_output(words[0...count], ['Battler', 'Top words']) unless words.empty?
  end
end

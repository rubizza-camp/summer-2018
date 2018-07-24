require './top_bad_words.rb'
require 'terminal-table'

# This class is needed for second level of task
class FirstLevel
  def initialize(bad)
    @bad = !bad.empty? ? bad.to_i : 1
    @first_level = TopBadWords.new
  end

  def line(value, elem, table)
    table << [elem, Rapper.new(elem).battle_count.to_s + ' баттла(ов)',
              value[1].to_s + ' нецензурных слов(а)',
              @first_level.obscenity_per_battle(elem).to_s + ' слов(а) на баттл',
              @first_level.words_per_round(elem).to_s + ' слов(а) в раунде']
  end

  def table_content(table)
    @bad.times do |index|
      value = @first_level.top_obscenity_check[index]
      elem = value[0]
      line(value, elem, table)
    end
  end

  def print_table
    table = Terminal::Table.new do |tb|
      table_content(tb)
    end
    puts table
  end
end

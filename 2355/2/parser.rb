require './top_bad_words.rb'
require './top_words.rb'
require 'terminal-table'

# This class is needed to parsing console params
class Parser
  def initialize
    @top_bad_words = []
    @top = TopBad.new
    @name = ''
  end

  # This method is needed in Parser class, but is doesn't depend on instance state
  # This method smells of :reek:UtilityFunction
  def bad_words(bad)
    !bad.empty? ? bad.to_i : 1
  end

  # This method is needed in Parser class, but is doesn't depend on instance state
  # This method smells of :reek:UtilityFunction
  def top_words(most)
    !most.empty? ? most.to_i : 30
  end

  def top_bad_words_values
    @top.battlers_names
    @top.top_obscenity_check
    @top_bad_words = (@top.top_obscenity.sort_by { |_key, val| val }).reverse
  end

  def name_value(battler_name)
    @name = battler_name
  end

  def print_top_words(most)
    t_w = TopWord.new(@name)
    t_w.ready_top_words
    t_w.res(top_words(most))
  end

  def raper
    @top.battlers_names
    @top.battlers
  end

  def name_check(most)
    if @name.empty?
      puts 'Choose your destiny!'
    elsif !raper.include?(@name)
      puts 'Я не знаю рэпера ' + @name + ', но знаю таких: '
      raper.each { |battler| puts battler }
    else
      print_top_words(most)
    end
  end

  def words_per_battle(elem)
    @top.average_bad_words_in_battle(elem).to_s
  end

  def words_per_round(elem)
    @top.average_words_in_round(elem).to_s
  end

  def table_content(table, bad)
    bad_words(bad).times do |index|
      value = @top_bad_words[index]
      elem = value[0]
      table << [elem, value[1].to_s + ' нецензурных слов(а)',
                words_per_battle(elem) + ' слов(а) на баттл',
                words_per_round(elem) + ' слов(а) в раунде']
    end
  end

  def print_table(bad)
    table = Terminal::Table.new do |tb|
      table_content(tb, bad)
    end
    puts table
  end
end

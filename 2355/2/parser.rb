require './top_bad_words.rb'
require './top_words.rb'
require 'terminal-table'

# This class is needed to parsing console params
class Parser
  attr_reader :bad_words, :top_words, :name

  def initialize
    @top_bad_words = []
    @top = TopBad.new
  end

  def bad_words=(bad)
    @bad_words = !bad.empty? ? bad.to_i : 1
  end

  def top_bad_words_values
    @top.battlers_names
    @top.top_obscenity_check
    @top_bad_words = (@top.top_obscenity.sort_by { |_key, val| val }).reverse
  end

  def top_words=(most)
    @top_words = !most.empty? ? most.to_i : 30
  end

  def name_value(battler_name)
    @name = battler_name
  end

  def print_top_words
    t_w = TopWord.new(@name)
    t_w.check_all_words
    t_w.pretexts_value
    t_w.top_words_counter
    t_w.res(top_words)
  end

  def raper
    @top.battlers_names
    @top.battlers
  end

  def name_check
    if @name.empty?
      puts 'Choose your destiny!'
    elsif !raper.include?(@name)
      puts 'Я не знаю рэпера ' + @name + ', но знаю таких: '
      raper.each { |battler| puts battler }
    else
      print_top_words
    end
  end

  def words_per_battle(elem)
    @top.average_bad_words_in_battle(elem).to_s
  end

  def words_per_round(elem)
    @top.average_words_in_round(elem).to_s
  end

  def print_table
    table = Terminal::Table.new do |tb|
      @bad_words.times do |index|
        value = @top_bad_words[index]
        elem = value[0]
        tb << [elem, value[1].to_s + ' нецензурных слов(а)',
               words_per_battle(elem) + ' слов(а) на баттл',
               words_per_round(elem) + ' слов(а) в раунде']
      end
    end
    puts table
  end
end

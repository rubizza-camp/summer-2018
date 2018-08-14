require 'pry'
require_relative 'battle.rb'
require_relative 'search_battles.rb'

# Class one raper
class Raper
  attr_reader :name
  def initialize(name, spis)
    @name = name
    @battles = spis
  end

  def all_words
    @all_words ||= @battles.sum(&:sum_all_words)
  end

  def bad_words
    @bad_words ||= @battles.sum(&:bad_words_count)
  end

  def sum_battles
    @sum_battles ||= @battles.count
  end

  def bad_words_in_battle
    @bad_words_in_battle = bad_words / sum_battles
  end

  def words_in_raund
    @words_in_raund = all_words / sum_battles / 3
  end
end

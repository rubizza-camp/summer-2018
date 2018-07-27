require 'pry'
require_relative 'battle.rb'
require_relative 'search_battles.rb'

# Class one raper
class Raper
  def initialize(name, spis)
    @name = name
    @battles = spis
  end

  def all_words
    @all_words = @battles.sum(&:battle.sum_all_words)
  end

  def bad_words
    @bad_words = @battles.sum(&:battle.bad_words_count)
  end

  def sum_battles
    @sum_battles = @battles.count
  end
end

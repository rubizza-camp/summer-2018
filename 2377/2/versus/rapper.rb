require_relative 'battle'
require_relative 'word_analyzer'
require 'russian_obscenity'
# This class keeps the information about rapper
class Rapper
  attr_reader :name, :battles
  def initialize(filename)
    @name = filename[/((\w|\d|.|\s)*?)(?=против|[vV][Ss] )/]
    @battles = []
  end

  def words_per_battle
    bad_words / @battles.size
  end

  def bad_words
    @battles.sum(&:count_bad_words)
  end

  def words_per_round
    @battles.sum(&:count_words_per_round)
  end

  def words
    @battles.map(&:words).flatten
  end

  def create_row
    [name,
     "#{@battles.size} battles",
     "#{bad_words} bad words",
     "#{words_per_battle} words per battle",
     "#{words_per_round} words per round"]
  end
end

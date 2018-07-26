require 'pry'
require_relative 'battle.rb'
require_relative 'search_battles.rb'

# Class one raper
class Raper
  attr_reader :all_words, :bad_words
  def initialize(name, spis)
    @name = name
    @battles = spis
    @all_words = 0
    @bad_words = 0
  end

  def count_all_words
    @battles.each { |battle| @all_words += battle.sum_all_words }
  end

  def count_bad_words
    @battles.each { |battle| @bad_words += battle.bad_words_count }
  end

  def sum_battles
    @sum_battles = @battles.count
  end
end

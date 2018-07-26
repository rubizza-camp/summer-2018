# require './files_reader'
# require './battle'
# require './author_reader'
# require 'pry'

# Author with rapper names and rapper battles
class Rapper
  attr_reader :battles, :name

  ROUNDS_COUNT = 3.to_f

  def initialize(name)
    @name = name
    @battles = []
  end

  def add_battles(battles_array)
    @battles += battles_array
  end

  def battles_count
    @battles.size
  end

  def bad_words
    @battles.map(&:bad_words).flatten.count
  end

  def bad_words_per_battle
    bad_words / battles_count
  end

  def words_per_round
    (@battles.map(&:all_words_count).inject(0, :+) / ROUNDS_COUNT).round(2)
  end
end

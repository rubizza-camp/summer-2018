require_relative 'battle'
# Author responsible for author info
class Author
  attr_reader :name, :battles
  def initialize(author_name)
    @name = author_name
    @battles = []
  end

  def name?(name)
    @name.include?(name) || name.include?(@name)
  end

  def add_battle(battle)
    @battles << battle
  end

  def bad_words
    @battles.map(&:bad_words).flatten
  end

  def bad_words_per_battles
    @battles.any? ? (bad_words.size.to_f / @battles.size) : 0
  end

  def words_percent_per_rounds
    @battles.map(&:words_per_round)
  end
end

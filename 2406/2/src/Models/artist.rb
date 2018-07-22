require 'russian_obscenity'
class Artist
  attr_reader :name, :battle_list

  def add_battle(battle)
    @battle_list << battle
  end

  def bad_words_capacity
    counter = 0
    @battle_list.each do |battle|
      counter += bad_words_in_battle(battle)
    end
    counter
  end

  def words_in_battle_average
    counter = 0
    @battle_list.each { |battle| counter += battle.count }
    counter / battle_capacity
  end

  def words_in_round_average
    words_in_battle_average / 3
  end

  def battle_capacity
    @battle_list.size
  end

  def initialize(name)
    @name = name
    @battle_list = []
  end

  private

  def bad_words_in_battle(battle)
    battle.count { |word| word.include?('*') || RussianObscenity.obscene?(word) }
  end
end

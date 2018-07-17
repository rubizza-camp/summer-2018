require 'russian_obscenity'
class Artist
  attr_reader :name, :battle_list

  def add_battle(battle)
    @battle_list << battle
  end

  def get_bad_words
    counter = 0
    @battle_list.each {|battle| battle.each{|word| counter += 1 if word.include?('*') || RussianObscenity.obscene?(word)}}
    counter
  end

  def get_words_in_battle_average
    0.0
  end

  def get_words_in_round_average
    0.0
  end

  def initialize(name)
    @name = name
    @battle_list = []
  end
end

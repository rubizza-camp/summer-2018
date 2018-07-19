require 'russian_obscenity'
require 'active_support/all'

# Class that initialize with name and stores the list of all rapper's battles,
# calculates different statistics about rapper
class Rapper
  attr_reader :name, :battle_list

  def initialize(name)
    @name = name
    @battle_list = []
  end

  def add_battle(battle_obj)
    battle_obj.class == Battle ? @battle_list << battle_obj : raise(RapperObjectError, battle_obj)
  end

  def number_of_words
    words.count
  end

  def number_of_rounds
    @battle_list.inject(0) { |all_rounds, battle| all_rounds + battle.rounds_number }
  end

  def number_of_battles
    @battle_list.count
  end

  def number_of_obscene_words
    words.select { |word| obscene?(word) }.count
  end

  def obscene_words_per_battle
    number_of_obscene_words.fdiv(number_of_battles)
  end

  def words_per_round
    number_of_words.fdiv(number_of_rounds)
  end

  def words
    @battle_list.inject([]) { |all_words, battle| all_words + battle.all_words }
  end

  def unique_words
    words.each_with_object(Hash.new(0)) { |word, hash| hash[to_lower(word).to_sym] += 1 }
  end

  private

  # Downcase russian symbols
  def to_lower(word)
    word.mb_chars.downcase!.to_s
  end

  def obscene?(word)
    return true if RussianObscenity.obscene?(word) || word.include?('*')
    false
  end
end

# Exception that is raised when object given to Rapper#new_battle is not an Battle object
class RapperObjectError < StandardError
  def initialize(object, message = nil)
    @object = object
    @message = message ? default_message : message
  end

  private

  def default_message
    "Error. #{@object} is not a Battle object"
  end
end

# Rapper class :/
class Rapper
  attr_reader :name, :battle_list

  def initialize(name)
    @name = name
    @battles_list = []
  end

  def add_battle(battle_obj)
    battle_obj.is_a?(Battle) ? @battles_list << battle_obj : raise(VersusExceptions::VersusObjectError, battle_obj)
  end

  def battles_number
    @battles_list.count
  end

  def rounds_number
    @battles_list.reduce(0) { |sum, battle| sum + battle.rounds_number }
  end

  def words_number
    words.count
  end

  def obscene_words_number
    obscene_words.count
  end

  def words
    @battles_list.reduce([]) { |words_array, battle| words_array + battle.words }
  end

  def each_word_occurrence
    words.each_with_object(Hash.new(0)) { |word, hash| hash[word.to_lower_symbol] += 1 }
  end

  def obscene_words
    @battles_list.reduce([]) { |words_array, battle| words_array + battle.obscene_words }
  end

  def each_word_occurrence_sorted
    each_word_occurrence.sort_by { |_word, number| -number }.to_h
  end

  def obscene_words_per_battle
    obscene_words_number.fdiv(battles_number)
  end

  def words_per_round
    words_number.fdiv(rounds_number)
  end
end

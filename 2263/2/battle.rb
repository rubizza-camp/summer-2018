# Battle class :/
class Battle
  attr_reader :rounds_list

  def initialize
    @rounds_list = []
  end

  def add_round(round_obj)
    round_obj.is_a?(Round) ? @rounds_list << round_obj : raise(VersusExceptions::VersusObjectError, round_obj)
  end

  def rounds_number
    @rounds_list.count
  end

  def words_number
    words.count
  end

  def obscene_words_number
    obscene_words.count
  end

  def words
    @rounds_list.reduce([]) { |words_array, round| words_array + round.words }
  end

  def obscene_words
    @rounds_list.reduce([]) { |obscene_words_array, round| obscene_words_array + round.obscene_words }
  end
end

# Battle class :/
class Battle
  attr_reader :rounds_list

  def initialize
    @rounds_list = []
  end

  def add_round(round_obj)
    round_obj.is_a?(Round) ? @rounds_list << round_obj : raise(BattleObjectError, round_obj)
  end

  def rounds_number
    @rounds_list.count
  end

  def words_number
    words_list.count
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

# Exception, that is raised when Battle takes not a Round object
class BattleObjectError < StandardError
  def initialize(obj, message = default_message)
    @obj = obj
    @message = message
  end

  private

  def default_message
    'Error. Given object is not is not an object of Round'
  end
end

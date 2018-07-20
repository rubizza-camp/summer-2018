require_relative 'battles_by_name_giver'

class WordsInRoundCounter
  include BattlesByNameGiver
  ROUNDS_IN_BATTLE = 3
  def initialize(battles, battler_name, count_of_battles)
    @battles = battles
    @battler_name = battler_name
    @count_of_battles = count_of_battles
  end

  def count
    number_of_words / (@count_of_battles * ROUNDS_IN_BATTLE)
  end

  private

  def number_of_words
    BattlesByNameGiver.take(@battles, @battler_name).map(&:text).join(' ').gsub(/[\p{P}]/, ' ').split.count
  end
end

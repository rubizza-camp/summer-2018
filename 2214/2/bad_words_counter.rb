require 'russian_obscenity'
require_relative 'battle'
require_relative 'battles_by_name_giver'

class BadWordsCounter
  include BattlesByNameGiver
  def initialize(battles, battler_name)
    @battles = battles
    @battler_name = battler_name
  end

  def count
    files.split.select { |word| RussianObscenity.obscene?(word) || word.include?('*') }.count
  end

  private

  def files
    BattlesByNameGiver.take(@battles, @battler_name).map(&:text).join(' ')
  end
end

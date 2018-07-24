require './obscenity.rb'

# This class is needed for first level of Task 2
class TopBadWords
  attr_reader :battlers, :top_obscenity

  def initialize
    @battlers = []
    @top_obscenity = {}
  end

  def battlers_names
    File.new('./battlers').each { |line| @battlers << line.delete("\n") }
  end

  # I don't know how don't use "check." twice
  # This method smells of :reek:FeatureEnvy
  def top_obscenity_values(check, name)
    check.check_battles_for_obscenity
    @top_obscenity[name] = check.rapper.obscenity.size
  end

  def top_obscenity_check
    battlers_names
    @battlers.each { |name| top_obscenity_values(Obscenity.new(name), name) }
    (@top_obscenity.sort_by { |_key, val| val }).reverse
  end

  def obscenity_per_battle(name)
    battler = Rapper.new(name)
    @top_obscenity[name] / battler.battle_count
  end

  # This method is needed in TopBadWords class, so it doesn't depend on instance state
  # This method smells of :reek:UtilityFunction
  def words_per_round(name, words = 0)
    battler = Rapper.new(name)
    count = battler.battle_count
    1.upto(count) do |number|
      words += Battle.new(battler.name, number).words_count
    end
    words / (count * 3)
  end
end

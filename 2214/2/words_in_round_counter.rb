class WordsInRoundCounter
  ROUNDS_IN_BATTLE = 3
  def self.count(battles, battler_name, count_of_battles)
    words = battles_of_battler(battles, battler_name).map(&:text).join(' ').gsub(/[\p{P}]/, ' ').split.count
    words / (count_of_battles * ROUNDS_IN_BATTLE)
  end

  def self.battles_of_battler(battles, battler_name)
    battles.select { |battle| battle.title.split('против').first.include? battler_name }
  end
end

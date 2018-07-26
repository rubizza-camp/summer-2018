module BattlesByNameGiver
  def self.take(battles, battler_name)
    battles.select { |battle| battle.title.split('против').first.include? battler_name }
  end
end

class Battle
  attr_reader :battle_title

  def initialize(battle_title)
    @battle_title = battle_title
  end

  def text
    Battle.read_battle(@battle_title)
  end

  def self.read_battle(battle_title)
    battle_file = File.open(battle_title, 'r')
    content = battle_file.read
    battle_file.close
    content.tr("\n", ' ')
  end
end

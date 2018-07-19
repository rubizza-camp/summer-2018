require './word'
require './lyrics'

# this class analyzes text of battle
class Battle
  def self.paired?(battle_file_path)
    battle_file_path.split(/( против | vs )/).first.include?(' & ')
  end
end

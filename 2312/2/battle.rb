require './word'
require './lyrics'

# this class analyzes text of battle
class Battle
  def initialize(battle_file_path)
    @battle_file_path = battle_file_path
  end

  def count_rounds
    File.open(@battle_file_path, 'r').select { |line| line[/Раунд \d/] }.count
  end

  def paired?
    @battle_file_path.split(/( против | vs )/).first.include?(' & ')
  end
end

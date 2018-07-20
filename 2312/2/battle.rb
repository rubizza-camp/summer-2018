require './word'
require './lyrics'

# this class analyzes text of battle
class Battle
  def initialize(battle_file_path)
    @battle_file_path = battle_file_path
  end

  def extract_battlers_names
    rapper_name = @battle_file_path.split(/( против | vs | VS )/).first + ' & '
    rappers_names = rapper_name.split(' & ')
    battlers_names = [rappers_names.first.strip]
    battlers_names << rappers_names.last.strip if paired?
    battlers_names
  end

  def count_rounds
    File.open(@battle_file_path, 'r').select { |line| line[/Раунд \d/] }.count
  end

  def paired?
    @battle_file_path.split(/( против | vs )/).first.include?(' & ')
  end
end

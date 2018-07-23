require './line'
# this class is needed to return the whole text of file as string
class Lyrics
  attr_reader :battle_file_path
  def initialize(battle_file_path)
    @battle_file_path = battle_file_path
  end

  def lyrics_from_battle
    File.open(battle_file_path, 'r').select { |line_text| line_text }.join(' ')
  end
end

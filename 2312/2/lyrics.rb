require './line'
# this class is needed to return the whole text of file as string
class Lyrics
  def initialize(battle_file_path, paired)
    @battle_file_path = battle_file_path
    @paired = paired
  end

  def text_by(rapper_name)
    if @paired
      lyrics_in_paired_battle_by(rapper_name)
    else
      lyrics_solo_battle
    end
  end

  private

  def lyrics_solo_battle
    File.open(@battle_file_path, 'r').select { |line_text| line_text }.join(' ')
  end

  def lyrics_in_paired_battle_by(rapper_name)
    line_belongs = false
    File.open(@battle_file_path, 'r').select do |line_text|
      line_belongs = Line.new(line_text).belongs_to?(rapper_name, line_belongs)
      next unless line_belongs
      line_text.strip
    end.join(' ')
  end
end

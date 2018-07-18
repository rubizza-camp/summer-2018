class Lyrics
  def initialize(battle_file_path, paired)
    @battle_file_path = battle_file_path
    @line_belongs_to_rapper = false
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
    File.open(@battle_file_path, 'r').select do |line_text|
      next unless line_belongs_to?(rapper_name, line_text)
      line_text.strip
    end.join(' ')
  end

  def line_belongs_to?(rapper_name, line)
    if line.start_with?(/\w+:/) && !line.include?("#{rapper_name}:")
      @line_belongs_to_rapper = false
    elsif line.include?("#{rapper_name}:") || @line_belongs_to_rapper
      @line_belongs_to_rapper = true
    end
  end
end

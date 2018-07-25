# this class is needed to return the whole text of file as string
class Lyrics
  attr_reader :battle_file_path
  def initialize(battle_file_path)
    @battle_file_path = battle_file_path
  end

  def lyrics_from_battle
    File.open(battle_file_path, 'r').select { |line_text| line_text }.join(' ')
  end

  def all_words_said
    lyrics_from_battle.split
  end

  def bad_words_said
    all_words_said.select { |word| Word.new(word).obscene? }.count
  end
end

require './word'
require './lyrics'

# this class analyzes text of battle
class Battle
  attr_reader :battle_file_path

  def initialize(battle_file_path)
    @battle_file_path = battle_file_path
  end

  def paired?
    @battle_file_path.partition(/( против | vs )/).first.include?(' & ')
  end

  def process_battle(info, rapper_name)
    info[1] += rapper_rounds
    info[6] += all_words_said_by(rapper_name).size
    info[3] += bad_words_said_by(rapper_name)
    info
  end

  private

  def rapper_rounds
    rounds = File.open(@battle_file_path, 'r').select { |line| line[/Раунд \d/] }.count
    rounds.zero? ? 1 : rounds
  end

  def all_words_said_by(rapper_name)
    Lyrics.new(@battle_file_path, paired?).text_by(rapper_name).split.map { |word| Word.new(word) }
  end

  def bad_words_said_by(rapper_name)
    all_words_said_by(rapper_name).count(&:obscene?)
  end
end

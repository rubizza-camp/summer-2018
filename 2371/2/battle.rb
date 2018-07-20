require_relative 'constants'

# The Battle responsible for battle info
class Battle
  attr_reader :curse_words
  def initialize(battle_file_name)
    @battle_text = File.read("./texts/#{battle_file_name}")
    @rounds = @battle_text.scan(ROUNDS_REGEX)
    @curse_words = @battle_text.scan(CURSE_WORDS_REGEX).flatten
  end

  def words_percent
    format('%.2f', @battle_text.split(' ').size /
          (@rounds.any? ? @rounds.size : 1)).to_f
  end
end

require_relative 'constants'

# The Battle responsible for battle info
class Battle
  attr_reader :curse_words
  def initialize(battle_text)
    @battle_text = battle_text
    all_words = @battle_text.scan(/[а-яА-Я]+/i)
    @curse_words = (all_words - (all_words - CURSE_WORDS_DICT)) \
    + battle_text.scan(/\W[а-яА-Я]*\*+[а-яА-Я]*\W/i).flatten
  end

  def words_per_round
    rounds = @battle_text.scan(ROUNDS_REGEX)
    format('%.2f', @battle_text.split(' ').size /
          (rounds.any? ? rounds.size : 1)).to_f
  end
end

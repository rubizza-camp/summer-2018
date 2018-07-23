require_relative 'constants'
# The Battle responsible for battle info
class Battle
  def initialize(battle_text)
    @battle_text = battle_text
  end

  def bad_words
    all_words = @battle_text.scan(/[а-яА-Я]+/i)
    star_words = @battle_text.scan(/\W[а-яА-Я]*\*+[а-яА-Я]*\W/i).flatten
    (all_words - (all_words - CURSE_WORDS_DICT)) + star_words
  end

  def words_per_round
    rounds = @battle_text.scan(/Раунд\s?\d+?/i)
    format('%.2f', @battle_text.split(' ').size /
          (rounds.any? ? rounds.size : 1)).to_f
  end
end

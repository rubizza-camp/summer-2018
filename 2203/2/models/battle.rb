require 'russian_obscenity'

# This class show battles with stats
class Battle
  WORDS_REGEXP = /[а-яА-Яa-zA-Z]+/

  def initialize(battle_text)
    @battle_text = battle_text
  end

  def all_words
    @battle_text.scan(WORDS_REGEXP)
  end

  def all_words_count
    all_words.size
  end

  def bad_words
    all_words.select { |word| word.include?('*') || RussianObscenity.obscene?(word) }
  end

  def bad_words_count
    bad_words.count
  end
end

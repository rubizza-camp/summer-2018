require 'russian_obscenity'

# This module calculate all words and only bad word
module WordsCalculator
  MIN_WORDS_LENGTH = 4

  def self.calculate_bad_words(battle)
    battle.select { |word| word.include?('*') || RussianObscenity.obscene?(word) }.count
  end

  def self.calculate_all_words(battle)
    battle.select { |word| word.length > MIN_WORDS_LENGTH }.count
  end
end

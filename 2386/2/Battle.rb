require 'russian_obscenity'
# Contain data about one battle
class Battle
  attr_reader :filename
  def initialize(filename)
    @filename = filename
    @words = words
  end

  def bad_per_round
    count_bad_words / count_rounds
  end

  def words
    @words = File.read("Rapbattle/#{@filename}").split
  end

  def words_count
    words.count
  end

  def count_round_word
    words.count { |word| word == 'Раунд' }
  end

  def count_rounds
    count_round_word.zero? ? 1 : count_round_word
  end

  def count_bad_words
    words.count do |word|
      word.include?('*') || RussianObscenity.obscene?(word)
    end
  end
end

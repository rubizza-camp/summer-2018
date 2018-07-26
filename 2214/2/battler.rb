require_relative 'battle'

class Battler
  BATTLES_FOLDER = 'Battles'.freeze
  attr_reader :name, :battles
  def initialize(name, battles)
    @name = name
    @battles = battles
  end

  def number_of_battles
    @battles.size
  end

  def number_of_bad_words
    @battles.map(&:bad_words_count).reduce(:+)
  end

  def bad_words_per_round
    (number_of_bad_words.to_f / number_of_battles).round(2)
  end

  def average_number_of_words
    @battles.map(&:words_in_round).reduce(:+) / battles.size
  end

  def describe_yourself
    [
      name,
      "#{number_of_battles} баттлов",
      "#{number_of_bad_words} нецензурных слов",
      "#{bad_words_per_round} слова на баттл",
      "#{average_number_of_words} слов в раунде"
    ]
  end
end

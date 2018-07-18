require_relative 'bad_words_counter'
require_relative 'words_in_round_counter'
require_relative 'battle'

class Battler
  BATTLES_FOLDER = 'Battles'.freeze
  attr_reader :name
  def initialize(name, battles)
    @name = name
    @battles = battles
  end

  def number_of_battles
    Dir.glob("#{BATTLES_FOLDER}/*#{@name}*").select { |title| title.split('против').first.include? @name }.count
  end

  def number_of_bad_words
    BadWordsCounter.count(@battles, @name)
  end

  def bad_words_per_round
    (number_of_bad_words.to_f / number_of_battles).round(2)
  end

  def average_number_of_words
    WordsInRoundCounter.count(@battles, @name, number_of_battles)
  end
end

require_relative 'bad_words_counter'
require_relative 'total_words_in_round_counter'

class Battler
  attr_reader :name
  def initialize(name, battles)
    @name = name
    @battles = battles
  end

  def number_of_battles
    Dir.glob("#{INPUT_FOLDER}/*#{@name}*").select { |title| title.split('против').first.include? @name }.count
  end

  def number_of_bad_words
    BadWordsCounter.count(@battles, @name)
  end

  def bad_words_per_round
    (number_of_bad_words.to_f / number_of_battles).round(2)
  end

  def average_number_of_words
    TotalWordsInRoundCounter.count(@battles, @name, number_of_battles)
  end
end

# This is class Raper
class Raper
  include Helper
  attr_reader :name, :battles
  def initialize(name, battles)
    @name    = name
    @battles = battles
  end

  def count_battles
    Dir.glob("#{Battle::FOLDER}/*#{name}*").reject do |file|
      File.directory? file
    end.count
  end

  def count_bad_words
    BadWordsCounter.new(@battles, @name).count
  end

  def bad_words_per_round
    (count_bad_words.to_f / count_battles).round(2)
  end

  def average_count_words
    WordsInRoundCounter.new(@battles, @name, count_battles).count
  end

  def show
    [
      name,
      Helper.formatting_word_battle(count_battles),
      Helper.formatting_word_obscence_word(count_bad_words),
      Helper.formatting_word_say(bad_words_per_round) + ' на баттл',
      Helper.formatting_word_say(average_count_words) + ' в раунде'
    ]
  end
end

require './words_counter.rb'

# Prepare top words statistic
class TopWordsStatistic
  attr_reader :name, :words_counter, :statistic

  ROUNDS_COUNT = 3

  def initialize(rapper_name)
    @name = rapper_name
    @words_counter = WordsCounter.new(name)
    @statistic = {
      battles_count: battles_count,
      bad_words: bad_words_count,
      bad_words_per_battle: bad_words_per_battle,
      words_per_round: all_words_per_round
    }
  end

  private

  def battles_count
    words_counter.battles_list.count
  end

  def bad_words_count
    words_counter.bad_words_count
  end

  def bad_words_per_battle
    (bad_words_count / battles_count.to_f).round(2)
  end

  def all_words_per_round
    (words_counter.all_words_count / battles_count / ROUNDS_COUNT.to_f).round(2)
  end
end

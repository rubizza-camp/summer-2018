# Class represents Helper to count words/bad words/words per round
class WordCounterHelper
  def initialize(bw_array)
    @words_count = 0
    @words_per_round = 0
    @array_round = []
    @bad_words_count = 0
    @bad_words_array = bw_array
  end

  attr_reader :words_count, :words_per_round, :array_round, :bad_words_count, :bad_words_array

  def save_word_count_round
    @array_round << @words_per_round
  end

  def add_word_count
    @words_count += 1
  end

  def add_word_count_round
    @words_per_round += 1
  end

  def add_bad_word_count
    @bad_words_count += 1
  end

  def drop_words_round_count
    @words_per_round = 0
  end
end

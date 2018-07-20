# class count stats: number bad words per battle, number words per round
class CountStats
  attr_reader :battler_stats, :words_per_round, :bad_words_per_battle

  def initialize(battler_stats)
    @battler_stats = battler_stats
  end

  def call
    check_words
    check_bad_words
    { words_per_round: words_per_round, bad_words_per_battle: bad_words_per_battle }
  end

  private

  def check_words
    answer = Hash.new(proc { count_words }).merge!(nil => proc { return 0 })
    @words_per_round = answer[battler_stats[:rounds]].call
  end

  def check_bad_words
    answer = Hash.new(proc { count_bad_words }).merge!(nil => proc { return 0 })
    @bad_words_per_battle = answer[battler_stats[:battles]].call
  end

  def count_words
    (battler_stats[:number_words].to_f / battler_stats[:rounds]).round(2)
  end

  def count_bad_words
    (battler_stats[:number_bad_words].to_f / battler_stats[:battles]).round(2)
  end
end

require_relative 'countwords'
require_relative 'countstats'

# Class battler with stats:
# name of battler, number of all battles,
# all bad words for life, bad words per one
# battle, words per one round, numbers of
# round, words that battler said
class Battler
  attr_reader :name, :stats, :avg_stats

  def initialize(battler_name)
    @name = battler_name
    @avg_stats = {}
    @stats = { battles: 0, number_bad_words: 0, rounds: 0, number_words: 0, words: [] }
  end

  def update_stats(battler_stats)
    @stats[:battles] += 1
    @stats[:rounds] += battler_stats[:rounds]
    @stats[:words] += battler_stats[:words]
    update_words
  end

  def update_words
    received_data = CountWords.new(stats[:words]).call
    @stats[:number_words] += received_data[:number_words]
    @stats[:number_bad_words] += received_data[:number_bad_words]
  end

  def create_str_for_output
    first = [name, "#{stats[:battles]} батлов", "#{stats[:number_bad_words]} нецензурных слова"]
    second = ["#{avg_stats[:bad_words_per_battle]} слов за батл", "#{avg_stats[:words_per_round]} слов за раунд"]
    first + second
  end

  def count_avg_stats
    received_stats = CountStats.new(stats).call
    @avg_stats[:words_per_round] = received_stats[:words_per_round]
    @avg_stats[:bad_words_per_battle] = received_stats[:bad_words_per_battle]
  end
end

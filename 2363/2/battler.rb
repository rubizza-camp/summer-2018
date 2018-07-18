require 'russian_obscenity'
require 'terminal-table'

# Class battler with stats:
# name of battler, number of all battles,
# all bad words for life, bad words per one
# battle, words per one round, numbers of
# round, words that battler said
class Battler
  attr_reader :name, :stats, :bad_words_per_battle
  def initialize(battler_name)
    @name = battler_name
    @stats = { battles: 0, bad_words: 0, rounds: 0, words: 0 } # hash store numbers
  end

  def update_stats(battler_states)
    @stats[:battles] += 1
    @stats[:bad_words] += battler_states[:bad_words]
    @stats[:rounds] += battler_states[:rounds]
    @stats[:words] += battler_states[:words]
  end

  def create_str_for_output
    first = [name, "#{stats[:battles]} батлов", "#{stats[:bad_words]} нецензурных слова"]
    second = ["#{bad_words_per_battle} слов за батл", "#{(stats[:words].to_f / stats[:rounds]).round(2)} слов за раунд"]
    first + second
  end

  def create_bad_words_per_battle
    @bad_words_per_battle = (stats[:bad_words].to_f / stats[:battles]).round(2)
  end
end

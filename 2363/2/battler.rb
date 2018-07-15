require 'russian_obscenity'
require 'terminal-table'

# Class battler with stats:
# name of battler, number of all battles,
# all bad words for life, bad words per one
# battle, words per one round, numbers of
# round, words that battler said
class Battler
  attr_reader :name, :stats, :bad_words_per_battle
  def initialize(*args)
    @name = args[0]
    @stats = { battles: 0, bad_words: 0, rounds: 0, words: 0 } # hash store numbers
    update_stats(args[1])
  end

  def update_stats(data)
    @stats[:battles] += 1
    @stats[:bad_words] += data[:bad_words]
    @stats[:rounds] += data[:rounds]
    @stats[:words] += data[:words]
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

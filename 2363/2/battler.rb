require 'russian_obscenity'
require 'terminal-table'

# Class battler with data:
# name of battler, number of all battles,
# all bad words for life, bad words per one
# battle, words per one round, numbers of
# round, words that battler said
class Battler
  attr_reader :name, :num, :bw_battle
  def initialize(*args)
    @name = args[0]
    @num = { battle: 0, bad_words: 0, rounds: 0, words: 0 }
    update(args[1])
  end

  def update(data)
    @num[:battle] += 1
    @num[:bad_words] += data[:bad_words]
    @num[:rounds] += data[:rounds]
    @num[:words] += data[:words]
  end

  def do_str
    first = [name, "#{num[:battle]} батлов", "#{num[:bad_words]} нецензурных слова"]
    second = ["#{bw_battle} слов за батл", "#{(num[:words].to_f / num[:rounds]).round(2)} слов за раунд"]
    first + second
  end

  def do_bw_battle
    @bw_battle = (num[:bad_words].to_f / num[:battle]).round(2)
  end
end

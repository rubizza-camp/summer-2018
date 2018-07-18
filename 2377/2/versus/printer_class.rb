require 'terminal-table'

class Printer
  def print(num, arr)
    rows = []
    i = 0
    while i < num
      rows << [arr[i].name, "#{arr[i].battles} battles", "#{arr[i].bad_words} bad words", "#{arr[i].words_per_battle} words per battle", "#{arr[i].words_per_round} words per round"]
      i += 1
    end
    table = Terminal::Table.new do |t|
      t.rows = rows
    end
    puts table
  end

  def print_words(num, hash)
    rows = []
    i = 1
    while i <= num
      rows << [hash.keys[i], hash[hash.keys[i]]]
      i += 1
    end
    table = Terminal::Table.new do |t|
      t.rows = rows
    end
    puts table
  end
end

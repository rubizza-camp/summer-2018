require 'terminal-table'
# Prints the information given in form of arrays
class Printer
  def printt(num, arr)
    rows = []
    print_lines(arr, num, rows)
    table = Terminal::Table.new do |tab|
      tab.rows = rows
    end
    puts table
  end

  def print(num, rappers, rounds)
    rows = []
    print_lines(num, rappers, rounds, rows)
    table = Terminal::Table.new do |tab|
      tab.rows = rows
    end
    puts table
  end

  def print_lines(num, rappers, rounds, rows)
    itr = 0
    while itr < num
      buf = []
      create_row(buf, rappers, rounds, itr)
      rows << buf
      itr += 1
    end
  end

  def create_row(buf, rappers, rounds, itr)
    buf << rappers[itr].name
    buf << "#{rappers[itr].battles} battles"
    buf << "#{rappers[itr].bad_words} bad words"
    buf << "#{rappers[itr].words_per_battle} words per battle"
    buf << "#{rounds[itr]} words per round"
  end

  # :reek:DuplicateMethodCall
  # :reek:FeatureEnvy
  # :reek:TooManyStatements
  def print_words(num, hash)
    rows = []
    itr = 1
    while itr <= num
      rows << [hash.keys[itr], "#{hash[hash.keys[itr]]} words"]
      itr += 1
    end
    table = Terminal::Table.new do |tab|
      tab.rows = rows
    end
    puts table
  end
end

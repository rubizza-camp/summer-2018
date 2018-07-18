require 'terminal-table'
# Prints the information given in form of arrays
class Printer
  def print(num, arr)
    rows = []
    print_lines(arr, num, rows)
    table = Terminal::Table.new do |tab|
      tab.rows = rows
    end
    puts table
  end

  # :reek:UtilityFunction
  # :reek:TooManyStatements
  # :reek:FeatureEnvy
  def print_lines(arr, num, rows)
    arr.first(num).each do |rapper|
      buf = []
      buf << rapper.name
      buf << "#{rapper.battles} battles"
      buf << "#{rapper.bad_words} bad words"
      buf << "#{rapper.words_per_battle} words per battle"
      buf << "#{rapper.words_per_round} words per round"
      rows << buf
    end
  end

  # :reek:DuplicateMethodCall
  # :reek:FeatureEnvy
  # :reek:TooManyStatements
  def print_words(num, hash)
    rows = []
    itr = 1
    while itr <= num
      rows << [hash.keys[itr], hash[hash.keys[itr]]]
      itr += 1
    end
    table = Terminal::Table.new do |tab|
      tab.rows = rows
    end
    puts table
  end
end

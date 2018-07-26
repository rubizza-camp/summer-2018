require 'terminal-table'
# Prints the information given in form of arrays
class Printer
  def initialize(rappers)
    @rappers = rappers
  end

  def print_first_level(num)
    table = Terminal::Table.new do |tab|
      create_rows(num, tab)
    end
    puts table
  end

  def print_second_level(num, hash)
    rows = []
    num.times do |number|
      rows << [word(hash, number), amount(hash, number)]
    end
    create_table(rows)
  end

  def word(hash, number)
    @word = hash.keys[number]
  end

  #:reek:FeatureEnvy
  def amount(hash, number)
    @amount = "#{hash[hash.keys[number]]} words"
  end

  def create_table(rows)
    table = Terminal::Table.new do |tab|
      tab.rows = rows
    end
    puts table
  end

  def create_rows(num, tab)
    num.times do |number|
      tab << @rappers[number].create_row
    end
  end
end

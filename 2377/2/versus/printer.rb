require 'terminal-table'
# Prints the information given in form of arrays
class Printer
  def print_first_level(num, rappers)
    table = Terminal::Table.new do |tab|
    num.times do |number|
      tab << rappers[number].create_row
    end
 end
    puts table
  end

  def print_second_level(num, hash)
    rows = []
    num.times do |number|
      rows << [hash.keys[number], "#{hash[hash.keys[number]]} words"]
    end
    create_table(rows)
  end

  def create_table(rows)
    table = Terminal::Table.new do |tab|
      tab.rows = rows
    end
    puts table
  end
end

require 'terminal-table'
# The Table responsible for printing stat
class Table
  def print(select = 1000)
    puts
    puts Terminal::Table.new rows: rows[0...select.to_i]
  end

  def rows
    raise NotImplementedError
  end
end

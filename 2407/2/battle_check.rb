require 'commander'
require 'terminal-table'
require_relative 'read_from_file_helper.rb'
require_relative 'battler_as_row_helper.rb'

# Check battles
class BattleCheck
  def describe_battlers(top_bad_words)
    show_top_battlers(ReadFromFile.sorted_battlers, top_bad_words)
  end

  private

  def show_top_battlers(battlers, top_bad_words)
    rows = battlers[0...top_bad_words].map { |battler| BattlerAsRow.get_battler_as_row(battler) }
    table = Terminal::Table.new rows: rows
    puts table
  end
end

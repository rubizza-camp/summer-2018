require 'terminal-table'
require_relative 'read_file_data_and_filenames_helper.rb'
require_relative 'battler_as_row_helper.rb'

# Work with battles depending on got options
# (cause I've completed only one task, we process only one option)
class BattleCheck
  def describe_battlers(top_bad_words)
    show_top_battlers(ReadFileDataAndFilenames.sorted_battlers, top_bad_words)
  end

  private

  def show_top_battlers(battlers, top_bad_words)
    rows = battlers[0...top_bad_words].map { |battler| BattlerAsRow.get_battler_as_row(battler) }
    table = Terminal::Table.new rows: rows
    puts table
  end
end

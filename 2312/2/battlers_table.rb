require 'terminal-table'
require './table_filler'

# BattlersTable prints a table of data, you provide to it
class BattlersTable
  attr_reader :num_top, :battlers
  def initialize(battlers, num_top)
    @battlers = battlers
    @num_top = num_top
  end

  def print
    terminate_with('ERROR: top number is zero') if num_top.zero?
    puts Terminal::Table.new rows: create_table[0...num_top]
  end

  private

  def terminate_with(message)
    puts message
    exit
  end

  def create_table
    @battlers.sort_by { |_name, info| info.stats.rapper_stats[:bad_words_num] }.reverse.to_h.keys.map do |name|
      TableFiller.new(name, battlers[name]).filled_line
    end
  end
end

require './modules'
require 'terminal-table'

# BattlersTable prints a table of data, you provide to it
class BattlersTable
  attr_reader :info_about_battlers, :num_top

  include ReturnInfo

  def initialize(info_about_battlers, num_top)
    @info_about_battlers = info_about_battlers
    @num_top = num_top
    @table = []
  end

  def print
    puts Terminal::Table.new rows: output_table[0...@num_top]
  end

  private

  def output_table(counter = -1)
    @info_about_battlers.sort_by { |_key, value| value[3] }.reverse.to_h.keys.each do |rapper|
      counter += 1
      fill_table_global(rapper, counter)
    end
    @table
  end

  def fill_table_global(rapper, counter)
    @table[counter] = [rapper]
    @table[counter] << "#{return_info(rapper, 0)} battles" << "#{return_info(rapper, 3)} bad words"
    fill_table_second(rapper, counter)
  end

  def fill_table_second(rapper, counter)
    @table[counter] << "#{return_info(rapper, 4)} bad/battle" << "#{return_info(rapper, 2)} words/round"
  end
end

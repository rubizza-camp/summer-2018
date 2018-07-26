require_relative './helper.rb'
require_relative './parser.rb'
require 'terminal-table'

class Statistic
  attr_reader :data

  def initialize
    @data = Helper.sort_data(Parser.new.read_data)
  end

  def print_result(result, headings)
    table = Terminal::Table.new(rows: result, style: { all_separators: true }, headings: headings)
    puts table
  end
end

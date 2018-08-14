require 'pry'
require 'terminal-table'
require_relative 'table_row.rb'
require_relative 'all_rapers.rb'

# Class table, show rating
class TableRating
  attr_reader :rows
  def initialize(num)
    @num = num
    @rows = []
  end

  def create_table
    top_rapers.each do |raper|
      @rows << TableRow.new(raper).row
    end
    puts Terminal::Table.new(rows: @rows)
  end

  def top_rapers
    rapers = AllRapers.new
    rapers.create_all_rapers
    @top_rapers = rapers.sorting(@num)
  end
end

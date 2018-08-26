require 'pry'
require 'optparse'
require 'terminal-table'
require_relative 'all_rapers.rb'
require_relative 'raper_presenter.rb'
require_relative 'sorting.rb'

# Class performing command --top-bad-words=
class CommandTopBadWords
  def initialize(parameter)
    @parameter = parameter
    @rapers ||= AllRapers.new
  end

  def sorting
    @sorting ||= Sorting.new(@rapers.all_rapers.values, @parameter)
  end

  def top_rapers
    @top_rapers ||= sorting.sorting_elements
  end

  def raper_presenter(raper)
    @raper_presenter = RaperPresenter.new(raper).row
  end

  def table_output
    puts Terminal::Table.new(rows: top_rapers.map { |raper| raper_presenter(raper) })
  end
end

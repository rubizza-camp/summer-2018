require 'pry'
require 'optparse'
require 'terminal-table'
require_relative 'all_rapers.rb'

OptionParser.new do |parser|
  parser.on('--top-bad-words=') do |parameter|
    rapers = AllRapers.new
    rapers.create_all_rapers
    top_rapers = rapers.sorting(parameter.to_i)
    puts Terminal::Table.new(rows: top_rapers.map(&:row))
  end
  # parser.on('--top-words=') do |parameter|
  #  v = SearchBattles.new(parameter).count_battles
  #  c = Raper.new(parameter, v).top_words(5)
  #  p v
  #  p c
  # end
end.parse!

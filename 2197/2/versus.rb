require 'pry'
require 'russian_obscenity'
require 'terminal-table'
require 'optparse'
require_relative 'handler'
require_relative 'battl'
require_relative 'artist'

OptionParser.new do |parser|
  # binding.pry
  parser.on('--top-bad-words=') do |top_bad_words|
    number_rappers = Handler.new.sort_top_rappers(top_bad_words.to_i)
    system('clear')
    puts Terminal::Table.new(rows: number_rappers.map(&:create_table_row))
  end
  parser.on('--help') do
    puts 'add --help to watch this text))'
    puts 'add --top-bad-words=<number> to ruby \
    (your_file) to show <number> the most abusive artists!'
  end
end.parse!

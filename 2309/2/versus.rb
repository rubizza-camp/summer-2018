require 'pry'
require 'optparse'
require_relative 'logic_performing_commands.rb'

OptionParser.new do |parser|
  parser.on('--top-bad-words=') do |parameter|
    top_bad_words = CommandTopBadWords.new(parameter.to_i)
    top_bad_words.top_rapers
    top_bad_words.table_output
  end
end.parse!

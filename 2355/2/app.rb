require './parser.rb'
require 'optparse'

OptionParser.new do |opts|
  opts.on('--top-bad-words=') do |bad|
    task = Parser.new
    task.bad_words = bad
    task.top_bad_words_values
    task.print_table
  end
  opts.on('--top-words=') do |most|
    task = Parser.new
    task.top_words = most
    opts.on('--name=') do |battler_name|
      task.name_value(battler_name)
      task.name_check
    end
  end
end.parse!

require './parser.rb'
require 'optparse'

OptionParser.new do |opts|
  opts.on('--top-bad-words=') do |bad|
    task = Parser.new
    task.top_bad_words_values
    task.print_table(bad)
  end
  opts.on('--top-words=') do |most|
    task = Parser.new
    opts.on('--name=') do |battler_name|
      task.name_value(battler_name)
      task.name_check(most)
    end
  end
end.parse!

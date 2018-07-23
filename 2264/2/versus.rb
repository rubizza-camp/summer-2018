require 'optparse'
require 'terminal-table'
require_relative 'storage'
require_relative 'rapper_data'
require_relative 'rappers_list'
require_relative 'top_bad_words_printer'
require_relative 'row_presenter'

options = { 'top-bad-words' => nil }

parser = OptionParser.new do |opts|
  opts.on('--top-bad-words=number') do |number|
    options['top-bad-words'] = number
  end

  opts.on('--help') do
    puts 'Usage:'
    puts 'Type --top-bad-words=N , there N - number of top rappers with bad fantasy'
  end
end

parser.parse!

TopBadWordsPrinter.new(options['top-bad-words']) unless options['top-bad-words'].nil?

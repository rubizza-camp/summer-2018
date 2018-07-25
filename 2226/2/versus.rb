require 'terminal-table'
require 'fuzzy_match'
require 'optparse'
require 'russian'
require 'yaml'
require_relative 'data_storage'
require_relative 'helper'
require_relative 'rapper'
require_relative 'battle'
require_relative 'top_bad_words_printer'
require_relative 'top_words_printer'
require_relative 'row_presenter'
require_relative 'rapper_data_store'

options = { 'top-bad-words' => nil, 'top-words' => 30, 'name' => nil }

parser = OptionParser.new do |opts|
  opts.banner = 'Use help for that programm'
  opts.on('-bad-words', '--top-bad-words=number', 'Enter number of rappers you want to see') do |number|
    options['top-bad-words'] = number
  end

  opts.on('-top-words', '--top-words=number', 'Enter number of top words you want to see') do |number|
    options['top-words'] = number
  end

  opts.on('-n', '--name=name', 'Enter name of the rapper you want to see') do |name|
    options['name'] = name
  end

  opts.on('-h', '--help', 'Use this option for more info') do
    puts opts
    exit
  end
end

parser.parse!

TopBadWordsPrinter.new(options['top-bad-words']) unless options['top-bad-words'].nil?

TopWordsPrinter.new(options['top-words'], options['name']) unless options['name'].nil?

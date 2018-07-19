require 'terminal-table'
require 'fuzzy_match'
require 'optparse'
require 'russian'
require 'yaml'
require_relative 'data_storage'
require_relative 'raper'
require_relative 'utility_methods'
require_relative 'list_of_rapers'
require_relative 'print_table'
require_relative 'print_top_words'
require_relative 'raper_decorator'

options = { 'top-bad-words' => nil, 'top-words' => 30, 'name' => nil }

parser = OptionParser.new do |opts|
  opts.banner = 'Use help for that programm'
  opts.on('-bad-words', '--top-bad-words=number', 'Enter number of rapers you want to see') do |number|
    options['top-bad-words'] = number
  end

  opts.on('-top-words', '--top-words=number', 'Enter number of top words you want to see') do |number|
    options['top-words'] = number
  end

  opts.on('-n', '--name=name', 'Enter name of the raper you want to see') do |name|
    options['name'] = name
  end

  opts.on('-h', '--help', 'Use this option for more info') do
    puts opts
    exit
  end
end

parser.parse!

PrintTable.new(options['top-bad-words']) unless options['top-bad-words'].nil?

PrintTopWords.new(options['top-words'], options['name']) unless options['name'].nil?

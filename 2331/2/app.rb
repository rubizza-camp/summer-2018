require_relative './command_line.rb'
require_relative './top_bad_words.rb'
require_relative './top_words.rb'

options = CommandLine.new.options

options[:top_bad_words] && TopBadWords.new(options).print_result
options[:name] && TopWords.new(options).print_result

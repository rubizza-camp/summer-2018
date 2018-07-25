require_relative 'top.rb'
require 'optparse'

OptionParser.new do |options|
  options.on('--top-bad-words=') do |max_bad_words|
    TopObsceneBattlers.new.show_top(max_bad_words.to_i)
  end
end.parse!

require 'optparse'
load 'first_level.rb'
load 'second_level.rb'

# Class check command line
class CommandLine
  attr_reader :value, :name, :num
  def initialize
    OptionParser.new do |opts|
      check_bad_words(opts)
      check_num(opts)
      check_name(opts)
    end.parse!
    BadWords.new(value) if value
    TopWords.new(name, num ? num : 30) if name
  end

  def check_bad_words(opts)
    opts.on('--top-bad-words=VALUE', 'Top of bad words') { |bad_words| @value = bad_words.to_i }
  end

  def check_num(opts)
    opts.on('--top-words=VALUE', 'Top of words') { |number| @num = number.to_i }
  end

  def check_name(opts)
    opts.on('--name=NAME', 'Name of raper') { |value_name| @name = value_name }
  end
end

CommandLine.new

require 'optparse'
load 'parser.rb'

# Class versus is main class
class Versus
  attr_reader :value, :name
  def initialize
    @value = 0
    @name = nil
    OptionParser.new do |opts|
      parse_top_bad_words(opts)
      parse_top_words(opts)
      parse_name(opts)
    end.parse!
    Parser.new(value, name)
  end

  def parse_top_bad_words(opts)
    opts.on('--top-bad-words=VALUE', 'Top of obscene rapers') do |count|
      @value = count.to_i
    end
  end

  def parse_top_words(opts)
    opts.on('--top-words=VALUE', 'Top of words') do |num|
      @value = num.to_i
    end
  end

  def parse_name(opts)
    opts.on('--name=Name', 'Name of raper') do |raper|
      @name = raper
    end
  end
end

Versus.new

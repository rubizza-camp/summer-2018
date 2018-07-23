require 'optparse'
require_relative 'obscene_rapers'
require_relative 'top_words'

# Class versus is main class
class Versus
  FILES_PATH = Dir['./rap-battles/*'].freeze

  attr_reader :value, :name

  def initialize
    @value = 0
    @name = nil
  end

  def run
    OptionParser.new do |opts|
      parse_top_bad_words(opts)
      parse_top_words(opts)
      parse_name(opts)
    end.parse!
    choose_class
  end

  private

  def choose_class
    if name
      TopWordsFinder.new(value, name, FILES_PATH).run
    else
      ObsceneRapersFinder.new(value, FILES_PATH).run
    end
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

Versus.new.run

require 'optparse'

# Parameters parser
class ParametersParser
  attr_reader :options
  def initialize
    @options = {}
    parse
  end

  private

  # :reek:TooManyStatements
  # :reek:NestedIterators
  def parse
    OptionParser.new do |opts|
      opts.on('--top-bad-words=', '') { |value| @options[:top_bad_words] = value }
      opts.on('--top-words=', '') { |value| @options[:top_words] = value }
      opts.on('--name=', '') { |value| @options[:name] = value }
    end.parse!
  end
end

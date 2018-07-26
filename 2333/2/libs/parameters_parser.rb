require 'optparse'

# Class, that parse command line arguments
class ParametersParser
  # :reek:TooManyStatements
  # :reek:NestedIterators
  def self.parse
    @options ||= {}
    OptionParser.new do |opts|
      opts.on('--top-bad-words=', '') { |value| @options[:top_bad_words] = value }
      opts.on('--top-words=', '') { |value| @options[:top_words] = value }
      opts.on('--name=', '') { |value| @options[:name] = value }
    end.parse!
    @options
  end
end

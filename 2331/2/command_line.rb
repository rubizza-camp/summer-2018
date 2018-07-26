require 'optparse'

class CommandLine
  attr_reader :options

  def initialize
    @options = {}
    create_parameters
  end

  private

  # :reek:NestedIterators
  # :reek:TooManyStatements
  # Disabled reek because this method implementation is better
  def create_parameters
    OptionParser.new do |opts|
      opts.on('--top-bad-words=', 'Number of obscene participants') { |count| @options[:top_bad_words] = count.to_i }

      opts.on('--top-words=', 'Favorite words') { |count| @options[:top_words] = count.to_i }

      opts.on('--name=', 'Rapper name') { |name| @options[:name] = name }
    end.parse!
  end
end

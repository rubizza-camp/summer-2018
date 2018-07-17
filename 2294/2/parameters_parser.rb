require 'optparse'

# Parse terminal parameters
class ParametersParser
  attr_reader :options
  def initialize
    @options = {}
    parse
  end

  private

  def parse
    OptionParser.new do |opts|
      add_options(opts, '--top-bad-words=', :top_bad_words)
      add_options(opts, '--top-words=', :top_words)
      add_options(opts, '--name=', :name)
    end.parse!
  end

  def add_options(opts, option, key)
    opts.on(option, '') { |value| @options[key] = value }
  end
end

require 'optparse'
require 'active_support/all'

class Help
  attr_reader :help_message

  def initialize
    @help_message = <<-HELP
      Usage: versus.rb [options]

        --help -h               displays this message
        --top-bad-words=<num>   displays <num> of the most rude rappers (default 5)
        --top-words=<num>       displays top <num> words of each rapper (default 30)
        --name=<name>           specifies the above options to given rapper name

      versus.rb is an analyzer of versus battles. All text files must be in "texts" folder which
      is located in the same directory with program file. The name of each file must mutch to
      next pattern: NAME_1 (VS|vs)|((П|п)ротив) NAME_2. Each file can include one or more rounds,
      if there are several rounds, they must be defined with line that matchs to
      ((Р|р)аунд NUM)|(NUM (Р|р)аунд) pattern.
    HELP
  end

  def show_help
    print @help_message
    exit
  end
end

# Parse command line arguments
class ArgsParser
  attr_reader :options

  # Gem syntax doesn't allow to reduse iterators nesting
  # :reek:NestedIterators
  def initialize
    @options = {}
    OptionParser.new do |option|
      option.on('-h', '--help') { |opt| @options[:help] = opt }
      option.on('--top-bad-words [VALUE]') { |opt| @options[:top_bad_words] = opt }
      option.on('--top-words [VALUE]') { |opt| @options[:top_words] = opt }
      option.on('--name VALUE') { |opt| @options[:name] = opt }
    end.parse!
    default_mapper(@options)
  end

  private

  # If argument takes without optional value it marks like :default
  def default_mapper(options)
    options.each { |key, value| options[key] = :default unless value }
  end
end

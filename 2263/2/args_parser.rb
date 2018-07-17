require 'optparse'

class ArgsParser
  attr_reader :help_message, :options
  def initialize
    @help_message = %{
      Usage: versus.rb [options]

      --help -h               displays this message

      -tbw --top-bad-words=<num>   displays <num> of the most rude rappers (default 5)

      -tw --top-words=<num>       displays top <num> words of each rapper (default 30)

      -n --name=<name>           specifies the above options to given rapper name

}
    @options = {}
    parse_options
  end

  def show_help
    print @help_message
  end

  private

  def parse_options
    OptionParser.new do |option|
      option.on('-h', '--help') { |opt| @options[:help] = opt }
      option.on('--top-bad-words [VALUE]') { |opt| @options[:top_bad_words] = opt }
      option.on('--top-words [VALUE]') { |opt| @options[:top_words] = opt }
      option.on('--name VALUE') { |opt| @options[:name] = opt }
    end.parse!
    @options.each { |key, value| @options[key] = :default unless value }
  end
end

require 'optparse'

class ArgsParser
  attr_reader :help_message, :options
  def initialize
    @help_message =%{
      Usage: versus.rb [options]

      --help -h               displays this message

      -tbw --top-bad-words=<num>   displays <num> of the most rude rappers (default 5)

      -tw --top-words=<num>       displays top <num> words of each rapper (default 30)

      -n --name=<name>           specifies the above options to given rapper name
      }
      @options = {}
      parse_orions
  end

  def show_help
    print @help_message
  end

  private
  
  def parse_orions
    OptionParser.new do |option|
      option.on("-h", "--help", "Show help") { |option| @options[:help] = option }
      option.on("-tbw", "--top-bad-words [VALUE]", "dododo") { |option| @options[:top_bad_words] = option }
      option.on("-tw", "--top-words [VALUE]", "dododo") { |option| @options[:top_words] = option }
      option.on("n", "--name VALUE", "dododo") { |option| @options[:name] = option }
    end.parse!
  end
end

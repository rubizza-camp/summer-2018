require 'active_support/all'

# Command line arguments parser for versus.rb
class ArgsValidator
  attr_reader :top_bad_words, :top_words, :name, :help

  def initialize
    ARGV.each do |arg|
      if arg =~ /(?<=^--top-bad-words=)\d+$/ # --top-bad-words=VALUE pattern
        @top_bad_words = arg.match(/(?<=^--top-bad-words=)\d+$/).to_s.to_i
        next
      elsif arg =~ /^--top-bad-words$/ # --top-bad-words pattern
        @top_bad_words = 5
        next
      elsif arg =~ /(?<=^--top-words=)\d+$/ # --top-words=VALUE pattern
        @top_words = arg.match(/(?<=^--top-words=)\d+$/).to_s.to_i
        next
      elsif arg =~ /^--top-words$/ # --top-words pattern
        @top_words = 30
        next
      elsif arg =~ /(?<=^--name=)\w+$/ # --name=VALUE pattern
        @name = arg.match(/(?<=^--name=)\w+$/).to_s
        next
      elsif arg =~ /(^--help$|^-h$)/ # --help or -h pattern
        @help = true
        view_help
        next
      end
      raise ValidatorOptionError, arg
    end
  end

  private

  def view_help
    puts <<-HELP.strip_heredoc
            Usage: versus.rb [options]
                --help -h               displays this message

                --top-bad-words=<num>   displays <num> of the most rude rappers (default 5)

                --top-words=<num>       displays top <num> words of each rapper (default 30)

                --name=<name>           specifies the above options to given rapper name
    HELP
    exit
  end
end

# Exception that is raised if the validator got incorrect option
class ValidatorOptionError < StandardError
  def initialize(option)
    @option = option
  end

  def show_message
    puts "Error. Option #{@option} isn't expected."
  end
end

require 'active_support/all'

# Command line arguments parser for versus.rb
# :reek:FeatureEnvy
# :reek:ControlParameter
class ArgsValidator
  attr_reader :top_bad_words, :top_words, :name, :help

  def initialize
    ARGV.each do |arg|
      if !check_top_bad_words(arg) && !check_top_words(arg) && !check_name(arg) && !check_help(arg)
        raise ValidatorOptionError, arg
      end
    end
  end

  private

  def check_top_bad_words(arg)
    if arg =~ /(?<=^--top-bad-words=)\d+$/
      @top_bad_words = arg.match(/(?<=^--top-bad-words=)\d+$/).to_s.to_i
      return true
    elsif arg =~ /^--top-bad-words$/
      @top_bad_words = 5
      return true
    end
    false
  end

  def check_top_words(arg)
    if arg =~ /(?<=^--top-words=)\d+$/
      @top_words = arg.match(/(?<=^--top-words=)\d+$/).to_s.to_i
      return true
    elsif arg =~ /^--top-words$/
      @top_words = 30
      return true
    end
    false
  end

  def check_name(arg)
    if arg =~ /(?<=^--name=)\w+$/
      @name = arg.match(/(?<=^--name=)\w+$/).to_s
      return true
    end
    false
  end

  def check_help(arg)
    if arg =~ /(^--help$|^-h$)/
      @help = true
      view_help
      return true
    end
    false
  end

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

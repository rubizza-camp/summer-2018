require 'io/console'
require 'optparse'
require 'docopt'
require_relative 'tasks/TopBadWords'
# require_relative 'tasks/TopWords'

# Read params
class Parser
  def args
    Docopt.docopt(doc)
  rescue Docopt::Exit => exp
    puts exp.message
    exit
  end

  def doc
    %{
    Battle analysis

    Usage:
      #{__FILE__} --top-bad-words=<top_bad_words_number>
      #{__FILE__} --top-words=<top_words_number> --name=<name>
      #{__FILE__} --name=<name>

    Options:
      --top-bad-words=<top_bad_words_number>
      --top-words=<top_words_number>
      --name=<name>
    }
  end

  def parse_and_run_task
    if arguments_for_top_bad_words_present?
      find_all_bad_words
    elsif arguments_for_top_words_present?
      find_favourite_battlers_words
    else
      show_error
    end
  end

  def arguments_for_top_bad_words_present?
    args['--top-bad-words']
  end

  def arguments_for_top_words_present?
    args['--name']
  end

  def number_of_bad_words
    args['--top-bad-words'].to_i
  end

  def member_name
    args['--name'].to_s
  end

  def find_all_bad_words
    TopBadWords.new(number_of_bad_words).print_top
  end

  def find_favourite_battlers_words
    TopWords.new(member_name, args['--top-words']).favourite_words
  end
end

Parser.new.parse_and_run_task

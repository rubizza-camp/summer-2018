require 'ru_propisju'
require 'yaml'
require_relative 'model/rapper'
require_relative 'model/battles_info'
require_relative 'controller/top_bad_controller'
require_relative 'controller/top_word_controller'
require_relative 'helpers/top_word_helper'
require_relative 'helpers/top_bad_helper'
require_relative 'view/pluralizer'
require_relative 'view/top_bad_view'
require_relative 'view/top_word_view'

# rubocop:disable Metrics/BlockNesting
destination = Dir.pwd + '/text'
if !ARGF.argv[0].nil?
  param = ARGF.argv[0].split('=')
  unless '--name'.eql?(param[0]) || '--help'.eql?(param[0])
    count = param[1].to_i
    if count < 1
      STDERR.puts("\nAborted! Wrong parameter \"#{param[0]}\" value. It can't be \"#{param[1]}\".\n")
      exit(false)
    end
  end

  if param[0].eql? '--top-bad-words'
    TopBadWordsController.new(destination, count).top_bad_word_rappers
  elsif param[0].eql? '--top-words'
    if !ARGF.argv[1].nil?
      second_param = ARGF.argv[1].split(/=/)
      unless second_param[0].eql? '--name'
        STDERR.puts("\nAborted! Wrong parameter \"#{second_param[0]}\".\n")
        exit(false)
      end
      r_name = second_param[1]
      TopWordController.new(destination, r_name, count).check_rapper_name
    else
      STDERR.puts("\nAborted! Wrong parameter \"--name\" missed.\n")
      exit(false)
    end
  elsif param[0].eql? '--name'
    TopWordController.new(destination, param[1], 30).check_rapper_name
  elsif param[0].eql? '--help'
    puts "\nCommand --name=<name> show top 30 the most often found words of Rapper <name>"
    puts 'Also using command --top-words=<count> with --name=<name> shows' \
         ' top <count> the most often found words of Rapper <name>'
    puts 'Usage: ruby versus.rb --name=Galat or ruby versus.rb --top-words=10 --name=Galat'
    puts "\nCommand --top-bad-words=<count> will show top <count> of most bad words Rappers"
    puts 'Usage: ruby versus.rb --top-bad-words=5'
    puts
  else
    STDERR.puts("\nAborted! Wrong parameter \"#{param[0]}\".\n")
    exit(false)
  end
else
  count = 1_000
  get_top_bad count, destination
end
# rubocop:enable Metrics/BlockNesting

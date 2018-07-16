require 'ru_propisju'
require_relative 'raper'
require_relative 'total_words'
require_relative 'top_bad'
require_relative 'rapers_list'
require_relative 'top_word_counter'

# rubocop:disable Metrics/LineLength
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
    get_top_bad count, destination
  elsif param[0].eql? '--top-words'
    if !ARGF.argv[1].nil?
      second_param = ARGF.argv[1].split(/=/)
      unless second_param[0].eql? '--name'
        STDERR.puts("\nAborted! Wrong parameter \"#{second_param[0]}\".\n")
        exit(false)
      end
      r_name = second_param[1]
      top_word_count destination, r_name, count
    else
      STDERR.puts("\nAborted! Wrong parameter \"--name\" missed.\n")
      exit(false)
    end
  elsif param[0].eql? '--name'
    top_word_count destination, param[1], 30
  elsif param[0].eql? '--help'
    puts "\nCommand --name=<name> show top 30 the most often found words of Raper <name>"
    puts 'Also using command --top-words=<count> with --name=<name> shows' \
         ' top <count> the most often found words of Raper <name>'
    puts 'Usage: ruby versus.rb --name=Galat or ruby versus.rb --top-words=10 --name=Galat'
    puts "\nCommand --top-bad-words=<count> will show top <count> of most bad words Rapers"
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
# rubocop:enable Metrics/LineLength
# rubocop:enable Metrics/BlockNesting

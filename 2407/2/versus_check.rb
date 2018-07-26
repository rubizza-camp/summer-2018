require 'commander'
require_relative 'battle_check.rb'

INPUT_FOLDER = 'rap-battles'.freeze

HELP_STRING = %(View got by this command number of battlers and info
                                     about total number of obscene words, number
                                     of obscene words per battle and total
                                     amount of words in each battle.).freeze

battlers_table = BattleCheck.new

OptionParser.new do |parser|
  parser.banner = 'Usage: ruby versus_check.rb [options]'
  parser.on('--top-bad-words=', HELP_STRING) do |top_bad_words|
    battlers_table.describe_battlers(top_bad_words.to_i)
  end
end.parse!

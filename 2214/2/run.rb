require_relative 'battle_expert'
require 'optparse'

restorator = BattleExpert.new
OptionParser.new do |parser|
  parser.on('--top-bad-words=') do |top_bad_words|
    restorator.describe_battlers(top_bad_words.to_i)
  end
  parser.on('--top-words=') do |top_words|
    parser.on('--name=') do |name|
      restorator.find_popular_words(top_words.to_i, name)
    end
  end
end.parse!

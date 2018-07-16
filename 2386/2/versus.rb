require_relative 'BattleAnalyzer'
require 'optparse'

analizer = BattleAnalyzer.new
OptionParser.new do |parser|
  parser.on('--top-bad-words=') do |top_bad_words|
    analizer.process_participants(top_bad_words)
  end
  parser.on('--top-words=') do |top_words|
    parser.on('--name=') do |name|
      analizer.partipicant_words(name, top_words.to_i)
    end
  end
end.parse!

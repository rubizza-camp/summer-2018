require_relative 'BattleAnalyzer'
require 'optparse'
require 'terminal-table'

analyzer = BattleAnalyzer.new
OptionParser.new do |parser|
  parser.on('--top-bad-words=') do |top_bad_words|
    analyzer.process_participants(top_bad_words)
  end
  parser.on('--top-words=') do |top_words|
    parser.on('--name=') do |name|
      analyzer.partipicant_words(name, top_words.to_i)
    end
  end
  parser.on('--help') do
    rows = [
      'To find best battler use: --top-bad-words=',
      'To find most popular battler words use: --top-words= with --name='
    ]
    puts rows
  end
end.parse!

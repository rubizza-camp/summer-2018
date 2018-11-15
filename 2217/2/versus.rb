require 'russian'
require_relative 'Versus'
require_relative 'BattleTable'

OptionParser.new do |options|
  options.banner = 'Usage: versus.rb [options]'
  options.on('--top-bad-words=', 'Displays table with top bad words') do |number|
    table = Terminal::Table.new do |terminal|
      BattleTable.top_bad_word_hash.reverse[0...number.to_i].to_h.each do |rapper, bad_words|
        terminal << BattleTable.top_bad_word_table(rapper, bad_words)
      end
    end
    puts table
  end

  options.on('--top-words=', 'Param for show top words') do |number|
    options.on('-n=', '--name=') do |name|
      BattleTable.top_word_options(name, number)
    end
  end

  options.on('-n', '--name=', 'Display 30ty top words for rapper.') do |name|
    BattleTable.top_word_options(name)
  end

  options.on('-h', '--help', 'Displays Help') do
    puts options
    exit
  end
end.parse!

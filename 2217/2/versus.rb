require 'russian'
require_relative 'Versus'
require_relative 'BattleTable'
require 'terminal-table'

OptionParser.new do |options|
  options.banner = 'Usage: versus.rb [options]'
  options.on('--top-bad-words=', 'Displays table with top bad words') do |number|
    table = Terminal::Table.new do |terminal|
      rapper_name = BattleTable.top_bad_word_hash.reverse[0...number.to_i].to_h
      rapper_name.each do |rapper, bad_words|
        terminal << BattleTable.top_bad_word_table(rapper, bad_words)
      end
    end
    puts table
  end

  options.on('--top-words=') do |number|
    options.on('-n=', '--name=') do |name|
      table = Terminal::Table.new do |terminal|
        top_word = BattleTable.top_word_hash(name).reverse[0...number.to_i].to_h
        top_word.each do |word, count|
          terminal << BattleTable.top_word_table(word, count)
        end
      end
      puts table
    end
  end

  options.on('-h', '--help', 'Displays Help') do
    puts options
    exit
  end
end.parse!

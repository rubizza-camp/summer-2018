require 'russian'
require_relative 'Versus'

OptionParser.new do |options|
  options.banner = 'Usage: versus.rb [options]'
  options.on('--top-bad-words=', 'Displays table with top bad words') do |number|
    table = Terminal::Table.new do |terminal|
      rapper_name = Versus.battle_hash.reverse[0...number.to_i].to_h
      rapper_name.each do |rapper, bad_words|
        terminal << Versus.output_table(rapper, bad_words)
      end
    end
    puts table
  end

  options.on('-h', '--help', 'Displays Help') do
    puts options
    exit
  end
end.parse!

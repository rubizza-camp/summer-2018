require_relative 'Versus'

@names = Versus.rapper_list(Versus.collect_all_names)
p @names

OptionParser.new do |options|
  options.on('--top-bad-words=') do |number|
    table = Terminal::Table.new do |terminal|
      rapper_name = Versus.battle_hash.reverse[0...number.to_i].to_h
      rapper_name.each do |rapper, bad_words|
        terminal << [rapper,
                     "#{Versus.find_battles(rapper)} батлов",
                     "#{bad_words} нецензурных слов",
                     "#{Versus.average_bad_words(rapper)} слов на баттл",
                     "#{Versus.find_average_round_words(rapper)} слов в раунде"]
      end
    end
    puts table
  end
end.parse!

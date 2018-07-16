require 'optparse'
require 'terminal-table'
require './russian_declensions.rb'
require './bad_words_counter.rb'

OptionParser.new do |options|
  options.on('--top-bad-words=') do |number|
    table = Terminal::Table.new do |row|
      BadWordsCounter.sorting_bad_words[0...number.to_i].to_h.each do |name, bad_words_count|
        rapper = TopWordsStatistic.new(name).statistic
        row << [
          name,
          "#{rapper[:battles_count]} #{RussianDeclensions.battles_count_for_raper(rapper[:battles_count])}",
          "#{bad_words_count} #{RussianDeclensions.bad_words(bad_words_count)}",
          "#{rapper[:bad_words_per_battle]} #{RussianDeclensions.word(rapper[:bad_words_per_battle])} на баттл",
          "#{rapper[:words_per_round]} #{RussianDeclensions.word(rapper[:words_per_round])} в раунде"
        ]
      end
    end
    puts table
  end
end.parse!

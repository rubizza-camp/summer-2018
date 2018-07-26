require 'optparse'
require './versus.rb'
require 'terminal-table'
require './TopBadWordsCounter.rb'
require './BattlerMostUsableWordsCounter.rb'
require './row.rb'

# rubocop:disable Style/MultilineBlockChain

options = { name: '', top_bad_words: 0, top_words: 30 }
OptionParser.new do |opts|
  opts.banner = 'Usage: example.rb [options]'

  opts.on('--top-bad-words [NUMBER]', Integer, 'Максимальное количество самых нецензурных участников') do |number|
    options[:top_bad_words] = number
  end
  opts.on('--name [NAME]', String, 'Имя участника') do |name|
    options[:name] = name
  end
  opts.on('--top-words [NUMBER]', Integer, 'Наиболее часто употребляемые слова') do |number|
    options[:top_words] = number || 30
  end
end.parse!

BATTLERS_NAMES_LIST = Battler.battler_names_list.freeze

if options[:top_bad_words] > 0
  all_information_about_battlers = BATTLERS_NAMES_LIST.map do |name|
    Battler.new(name).all_information_about_battler
  end.sort_by { |key| key[:bad_words_count] }.reverse
  rows = all_information_about_battlers.first(options[:top_bad_words]).inject([]) do |row, name|
    row << Row.new(name[:name],
                   name[:battles_count],
                   name[:bad_words_count],
                   name[:words_in_battle],
                   name[:words_in_raund]).run
  end
  table = Terminal::Table.new rows: rows
  puts table
end

return if options[:name].empty?
name_battler = []
battler = Battler.new(options[:name])
BATTLERS_NAMES_LIST.each { |name| name_battler << name.split.first }
if name_battler.include?(options[:name])
  count_words = BattlerMostUsableWordsCounter.new(battler.all_battles_text)
                                             .run
                                             .pop(options[:top_words])
                                             .reverse
  rows = count_words.inject([]) { |row, (word, count)| row << [word.to_s, "#{count} раз"] }
  table = Terminal::Table.new rows: rows
  puts table
else
  puts "Рэпер #{options[:name]} мне не известен. Зато мне известны: "
  puts BATTLERS_NAMES_LIST.pop(3)
  puts '...'
end
# rubocop:enable Style/MultilineBlockChain

require 'optparse'
require './versus.rb'
require 'terminal-table'
require './TopBadWordsCounter.rb'
require './BattlerMostUsableWordsCounter.rb'
require './row.rb'
require 'pry-rails'

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

if options[:top_bad_words] > 0
  all_information_about_battlers = Battler.battler_names_list.map do |name|
    battler = Battler.new(name)
    battles_count = battler.battles_count
    words_in_battle = battler.words_in_battle
    words_in_raund = battler.words_in_raund
    count = BadWordsCounter.new(battler.all_battles_text).run
    { name: name,
      bad_words_count: count,
      battles_count: battles_count,
      words_in_raund: words_in_raund,
      words_in_battle: words_in_battle }
  end
  all_information_about_battlers = all_information_about_battlers.sort_by { |key| key[:bad_words_count] }.reverse
  rows = []
  all_information_about_battlers.first(options[:top_bad_words]).each do |name|
    rows << Row.new(name[:name],
                    name[:battles_count],
                    name[:bad_words_count],
                    name[:words_in_battle],
                    name[:words_in_raund]).run
  end
  table = Terminal::Table.new rows: rows
  puts table
end

return if options[:name].empty?
rows = []
name_battler = []
names = Battler.battler_names_list
names.each { |name| name_battler << name.split.first }
if name_battler.include?(options[:name])
  count_words = BattlerMostUsableWordsCounter.new(Battler.new(options[:name]).all_battles_text).run
  count_words = count_words.pop(options[:top_words]).reverse
  count_words.each do |word, count|
    rows << [word.to_s, "#{count} раз"]
  end
  table = Terminal::Table.new rows: rows
  puts table
else
  puts "Рэпер #{options[:name]} мне не известен. Зато мне известны: "
  puts names.pop(3)
  puts '...'
end

require 'optparse'
require './versus.rb'
require 'terminal-table'

options = { name: '', top_bad_words: 0, top_words: 30 }
OptionParser.new do |opts|
  opts.banner = 'Usage: example.rb [options]'

  opts.on('--top-bad-words [NUMBER]', Integer, 'Максимальное количество самых нецензурных участников') do |number|
    options[:top_bad_words] = number
  end
  opts.on('--name [NAME]', String, 'Имя участника') do |name|
    options[:name] = name
  end
  opts.on('--top-words [NUMBER]', Integer, 'Любимые слова человека') do |number|
    options[:top_words] = number || 30
  end
end.parse!

if options[:top_bad_words] > 0
  battlers = Battler.battler_names_list
                    .map { |name| Battler.new(name) }
                    .sort_by(&:bad_words_count)
                    .pop(options[:top_bad_words])
                    .reverse
  rows = []
  ending = ''
  battlers.each do |member|
    battles = member.battles_count
    if battles < 2 
      ending = ''
    elsif battles > 1 && battles <= 4
      ending = 'a'
    elsif battles >= 5
      ending = 'ов'
    end
    rows << [member.name.to_s,
             " #{battles} батл" + ending,
             " #{member.bad_words_count} нецензурных слов ",
             " #{member.words_in_battle}  слова на батл ",
             " #{member.words_in_raund} слов в раунде"]
  end
  table = Terminal::Table.new rows: rows
  puts table
end

unless options[:name].empty?
  rows = []
  name_battler = []
  names = Battler.battler_names_list
  names.each { |name| name_battler << name.split.first }
  if name_battler.include?(options[:name])
    result = Battler.new(options[:name])
                    .text_without_preposition.split(' ')
                    .each_with_object(Hash.new(0)) do |word, counter|
      counter[word] += 1
    end
    counter = result.to_a.sort_by { |_word, count| count }
    counter = counter.pop(options[:top_words]).reverse
    counter.each do |word, count|
      rows << [word.to_s, "#{count} раз"]
    end
    table = Terminal::Table.new rows: rows
    puts table
  else
    puts "Рэпер #{options[:name]} мне не известен. Зато мне известны: "
    puts names.pop(3)
    puts '...'
  end
end


class TopBadWordsCounter

end

class BattlerMostUsableWordsCounter
end
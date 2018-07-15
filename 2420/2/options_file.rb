require 'optparse'
require './versus.rb'
require 'terminal-table'

# rubocop:disable Layout/Tab
# rubocop:disable Style/UnneededInterpolation
# rubocop:disable Metrics/LineLength
# rubocop:disable Style/SymbolProc
# rubocop:disable Layout/BlockAlignment

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
  battler = Battler.battler_names_list.map { |name| Battler.new(name) }
		battler = battler.sort_by { |name_battler| name_battler.bad_words_count }
		battler = battler.pop(options[:top_bad_words]).reverse
		rows = []
		battler.each { |member| rows << ["#{member.name}", "#{member.battles_count} батлов", "#{member.bad_words_count} нецензурных слов ", " #{member.words_in_battle}  слова на батл ", " #{member.words_in_raund} слова в раунде"] }
		table = Terminal::Table.new rows: rows
		puts table
end

unless options[:name].empty?
		rows = []
		name_battler = []
		Battler.battler_names_list.each_index { |index| name_battler[index] = Battler.battler_names_list[index].split.first.to_str }
		if name_battler.include?(options[:name])
	 		result = Battler.new(options[:name]).text_without_preposition.split(' ').each_with_object(Hash.new(0)) do |word, counter|
	 		counter[word] += 1
		end
				counter = result.to_a.sort_by { |_word, count| count }
				counter = counter.pop(options[:top_words]).reverse
				counter.each do |word, count|
	  				rows << ["#{word}", "#{count} раз"]
	 			end
				table = Terminal::Table.new rows: rows
				puts table
		else
				puts "Рэпер #{options[:name]} мне не известен. Зато мне известны: "
				puts Battler.battler_names_list.pop(3)
				puts '...'
		end
end
# rubocop:enable Layout/Tab
# rubocop:enable Style/UnneededInterpolation
# rubocop:enable Metrics/LineLength
# rubocop:enable Style/SymbolProc
# rubocop:enable Layout/BlockAlignment

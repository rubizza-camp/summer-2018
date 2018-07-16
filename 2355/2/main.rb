require './top_bad_words.rb'
require './top_words.rb'
require 'optparse'
require 'terminal-table'

# rubocop:disable Lint/UnusedBlockArgument
# rubocop:disable Metrics/LineLength
# rubocop:disable Metrics/BlockLength
# rubocop:disable Style/UnneededInterpolation
# rubocop:disable Style/ConditionalAssignment
# rubocop:disable Layout/IndentationConsistency
# rubocop:disable Layout/IndentationWidth
# rubocop:disable Layout/ElseAlignment
# rubocop:disable Layout/Tab
# rubocop:disable Layout/TrailingWhitespace
top_words = 30
name_b = 'MC Неизвестный'

OptionParser.new do |opts|
  opts.on('--top-bad-words=') do |bad|
  	if !bad.empty?
  		bad_words = bad.to_i
  	else
  		bad_words = 1
  	end
		top = TopBad.new
		top.set_battlers_names
		top.set_top_obscenity
		top_bad_words = top.top_obscenity.sort_by { |key, val| val }
		top_bad_words = top_bad_words.reverse
    table = Terminal::Table.new do |t|
    	(bad_words - 1).times do |i|
    		t << ["#{top_bad_words[i][0]}", "#{top_bad_words[i][1]}" + ' нецензурных слов(а)', "#{top.average_bad_words_in_battle("#{top_bad_words[i][0]}")}" + ' слов(а) на баттл', "#{top.average_words_in_round("#{top_bad_words[i][0]}")}" + ' слов(а) в раунде']
  			t << :separator
    	end
    	i = bad_words - 1
    	t << ["#{top_bad_words[i][0]}", "#{top_bad_words[i][1]}" + ' нецензурных слов(а)', "#{top.average_bad_words_in_battle("#{top_bad_words[i][0]}")}" + ' слов(а) на баттл', "#{top.average_words_in_round("#{top_bad_words[i][0]}")}" + ' слов(а) в раунде']
    end
    puts table
  end

  opts.on('--top-words=') do |top_w|
  	if !top_w.empty? 
      top_words = top_w.to_i
  	else
  		top_words = 30
  	end
    opts.on('--name=') do |b_name|
      if b_name.empty? 
        puts'Choose your destiny!'
  		else
  			name_b = b_name
        top = TopBad.new
        top.set_battlers_names
        if top.battlers.index("#{name_b}").nil?
          puts 'Я не знаю рэпера ' + "#{name_b}" + ', но знаю таких: '
          top.battlers.each { |battl| puts battl }
        else
          t_w = TopWord.new("#{name_b}")
          t_w.check_all_words
          t_w.top_words_counter
          t_w.res(top_words)
        end
      end
    end
  end
end.parse!
# rubocop:enable Lint/UnusedBlockArgument
# rubocop:enable Metrics/LineLength
# rubocop:enable Metrics/BlockLength
# rubocop:enable Style/UnneededInterpolation
# rubocop:enable Style/ConditionalAssignment
# rubocop:enable Layout/IndentationConsistency
# rubocop:enable Layout/IndentationWidth
# rubocop:enable Layout/ElseAlignment
# rubocop:enable Layout/Tab
# rubocop:enable Layout/TrailingWhitespace

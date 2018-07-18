require './top_bad_words.rb'
require './top_words.rb'
require 'optparse'
require 'terminal-table'

# rubocop:disable Metrics/BlockLength
# This disable is needed because this block is the main logic of the program.
OptionParser.new do |opts|
  opts.on('--top-bad-words=') do |bad|
    bad_words = if !bad.empty?
                  bad.to_i
                else
                  1
                end
    top = TopBad.new
    top.set_battlers_names
    top.set_top_obscenity
    top_bad_words = top.top_obscenity.sort_by { |_key, val| val }
    top_bad_words = top_bad_words.reverse
    table = Terminal::Table.new do |t|
      (bad_words - 1).times do |i|
        t << [top_bad_words[i][0],
              top_bad_words[i][1].to_s + ' нецензурных слов(а)',
              top.average_bad_words_in_battle(top_bad_words[i][0]).to_s + ' слов(а) на баттл',
              top.average_words_in_round(top_bad_words[i][0]).to_s + ' слов(а) в раунде']
        t << :separator
      end
      i = bad_words - 1
      t << [top_bad_words[i][0],
            top_bad_words[i][1].to_s + ' нецензурных слов(а)',
            top.average_bad_words_in_battle(top_bad_words[i][0]).to_s + ' слов(а) на баттл',
            top.average_words_in_round(top_bad_words[i][0]).to_s + ' слов(а) в раунде']
    end
    puts table
  end

  opts.on('--top-words=') do |top_w|
    top_words = if !top_w.empty?
                  top_w.to_i
                else
                  30
                end
    opts.on('--name=') do |b_name|
      if b_name.empty?
        puts 'Choose your destiny!'
      else
        name_b = b_name
        top = TopBad.new
        top.set_battlers_names
        if !top.battlers.include?(name_b)
          puts 'Я не знаю рэпера ' + name_b + ', но знаю таких: '
          top.battlers.each { |battler| puts battler }
        else
          t_w = TopWord.new(name_b)
          t_w.check_all_words
          t_w.top_words_counter
          t_w.res(top_words)
        end
      end
    end
  end
end.parse!
# rubocop:enable Metrics/BlockLength

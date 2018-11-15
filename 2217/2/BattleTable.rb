require 'russian'
require 'terminal-table'
require_relative 'Versus'

RAPPERS_LIST = Versus.rapper_list(Versus.collect_all_names)

# module BattleTable
module BattleTable
  def self.top_bad_word_hash
    hash = RAPPERS_LIST.each_with_object(Hash.new(0)) do |rapper, total_bad_words|
      rapper = rapper
      total_bad_words[rapper] += Versus.count_bad_words(rapper)
    end
    hash.sort_by { |_rapper, total_bad_words| total_bad_words }
  end

  def self.top_word_hash(name)
    Versus.count_top_words(name).sort_by { |_word, count| count }
  end

  def self.syntax_output(number)
    return Russian.p(number, 'слово', 'слова', 'слов', 'слова') if number.class == Float
    Russian.p(number, 'слово', 'слова', 'слов')
  end

  def self.top_bad_word_table(name, bad_words)
    average_bad_words = Versus.average_bad_words(name)
    average_round_words = Versus.find_average_round_words(name)
    count_battles = Versus.count_battles(name)
    [name,
     "#{count_battles} #{Russian.p(count_battles, 'батл', 'батла', 'батлов')}",
     "#{bad_words} нецензурных #{syntax_output(bad_words)}",
     "#{average_bad_words} #{syntax_output(average_bad_words)} на батл",
     "#{average_round_words} #{syntax_output(average_round_words)} в раунде"]
  end

  def self.top_word_table(word, count)
    "#{word} - #{count} #{Russian.p(count, 'раз', 'раза', 'раз')}"
  end

  def self.top_word_options(name, number = 30)
    if RAPPERS_LIST.include?(name) && Versus.check_name_synonym(name)
      top_word_hash(name).reverse[0...number.to_i]
                         .to_h
                         .each { |word, count| puts top_word_table(word, count) }
    else
      puts "Рэпер #{name} мне не известен. Зато известны:"
      puts RAPPERS_LIST
    end
  end
end

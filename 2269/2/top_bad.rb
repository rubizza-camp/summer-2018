# This method returns top Rapers uses bad words
class TopBad
  def self.plural_battle(value)
    value.to_s.ljust(2) + ' ' +
      RuPropisju.choose_plural(value, 'баттл', 'баттла', 'баттлов').ljust(7) + ' | '
  end

  def self.plural_bad(value)
    value.to_s.ljust(4) + ' ' +
      RuPropisju.choose_plural(value, 'нецензурное слово', 'нецензурных слова', 'нецензурных слов').ljust(17) + ' | '
  end

  def self.plural_word_dec(value, end_phrase)
    value.to_s.ljust(6) + ' ' +
      RuPropisju.choose_plural(value, 'слово', 'слова', 'слова').ljust(5) + end_phrase
  end

  def self.plural_word(value, end_phrase)
    value.to_s.ljust(5) + ' ' +
      RuPropisju.choose_plural(value, 'слово', 'слова', 'слов').ljust(5) + end_phrase
  end
end

def top_bad_word_rapers(top, destination)
  rapers = get_rapers_list destination

  rapers.each do |_key, value|
    value.file_name.each do |file|
      hash = word_counter(destination + '/' + file)
      value.set_result hash[:total], hash[:bad], hash[:round]
    end
  end
  print_out rapers, top
end

def print_out(rapers, top)
  delimiter = 1
  rapers.sort_by { |_k, val| [-val.bad_words] }.each do |_key, value|
    break if delimiter > top
    puts result_string value, value.bad_words.fdiv(value.battles).round(2)
    delimiter += 1
  end
end

def result_string(raper, average)
  raper.name.ljust(25) + ' | ' + TopBad.plural_battle(raper.battles) +
    TopBad.plural_bad(raper.bad_words) +
    TopBad.plural_word_dec(average, ' на баттл | ') +
    TopBad.plural_word(raper.words_round, ' в раунде |')
end

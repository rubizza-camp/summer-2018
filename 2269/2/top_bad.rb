# This method returns top Rapers uses bad words
# :reek:TooManyStatements
# :reek:NestedIterators
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

# :reek:DuplicateMethodCall
# :reek:FeatureEnvy
# :reek:TooManyStatements
def print_out(rapers, top)
  delimiter = 1
  rapers.sort_by { |_k, val| [-val.bad_words] }.each do |_key, value|
    break if delimiter > top
    bad_words = value.bad_words
    result = value.name.ljust(25) + ' | ' +
             value.battles.to_s.ljust(2) + ' ' +
             RuPropisju.choose_plural(value.battles, 'баттл', 'баттла', 'баттлов').ljust(7) + ' | ' +
             value.bad_words.to_s.ljust(4) + ' ' +
             RuPropisju.choose_plural(bad_words, 'нецензурное', 'нецензурных', 'нецензурных') + ' ' +
             RuPropisju.choose_plural(bad_words, 'слово', 'слова', 'слов').ljust(5) + ' | ' +
             bad_words.fdiv(value.battles).round(2).to_s.ljust(6) + ' ' +
             RuPropisju.choose_plural(bad_words.fdiv(value.battles).round(2), 'слово', 'слова', 'слова') + ' на баттл | '.ljust(12) +
             value.words_round.to_s.ljust(5) + ' ' +
             RuPropisju.choose_plural(value.words_round, 'слово', 'слова', 'слов').ljust(5) +
             ' в раунде |'.ljust(11)
    puts result
    delimiter += 1
  end
end

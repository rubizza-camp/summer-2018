# Class creates view of top bad Rappers
class TopBadWordView
  def self.write_to_console(rapper, average)
    result = rapper.name.ljust(25) + ' | ' + WordPluralizeHelper.plural_battle(rapper.battles_counter) +
             WordPluralizeHelper.plural_bad(rapper.words_info_during_battles.bad_words)
    puts write_to_console_helper(rapper, average, result)
  end

  def self.write_to_console_helper(rapper, average, result)
    result + WordPluralizeHelper.plural_word_dec(average, ' на баттл | ') +
      WordPluralizeHelper.plural_word(rapper.words_info_during_battles.words_round, ' в раунде |')
  end
end
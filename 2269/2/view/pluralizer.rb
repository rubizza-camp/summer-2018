# This method returns right Plural of russian word in dependency of numeral.
class WordPluralizeHelper
  def self.plural_battle(value)
    value.to_s.ljust(2) + ' ' +
      RuPropisju.choose_plural(value, 'баттл', 'баттла', 'баттлов').ljust(7) + ' | '
  end

  def self.plural_bad(value)
    value.to_s.ljust(5) + ' ' +
      RuPropisju.choose_plural(value, 'нецензурное слово', 'нецензурных слова', 'нецензурных слов').ljust(17) + ' | '
  end

  def self.plural_word_dec(value, end_phrase)
    value.to_s.ljust(7) + ' ' +
      RuPropisju.choose_plural(value, 'слово', 'слова', 'слова').ljust(5) + end_phrase
  end

  def self.plural_word(value, end_phrase)
    value.to_s.ljust(5) + ' ' +
      RuPropisju.choose_plural(value, 'слово', 'слова', 'слов').ljust(5) + end_phrase
  end
end

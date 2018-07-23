# This is class BadWordsCounter
class BadWordsCounter
  FILE_BAD_WORDS       = 'bad_words.json'.freeze
  DICTIONARY_BAD_WORDS = JSON.parse(File.read(FILE_BAD_WORDS))
  def initialize(battles, raper_name)
    @battles = battles
    @raper_name = raper_name
  end

  def count
    files.split.select { |word| check_bad_words(word) }.count
  end

  private

  def files
    @battles.map(&:text).join(' ')
  end

  def check_bad_words(str)
    str =~ /\*/ || RussianObscenity.obscene?(str) ||
      DICTIONARY_BAD_WORDS.include?(str)
  end
end

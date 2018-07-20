# Search bad words
class BadWord < Word
  FILE_BAD_WORDS       = 'bad_words.json'.freeze
  DICTIONARY_BAD_WORDS = JSON.parse(File.read(FILE_BAD_WORDS))
  attr_reader :bad_words
  def initialize(rap_files)
    super
    @bad_words = []
  end

  def fetch_bad_words
    fetch_words.flatten.uniq
  end

  def handling_text(text)
    arr_words = super
    handling_bad_words(arr_words)
  end

  private

  def handling_bad_words(arr_words)
    arr_words.select! { |str| check_bad_words(str) }
    @bad_words |= arr_words.uniq
  end

  def check_bad_words(str)
    str =~ /\*/ || RussianObscenity.obscene?(str) ||
      DICTIONARY_BAD_WORDS.include?(str)
  end
end

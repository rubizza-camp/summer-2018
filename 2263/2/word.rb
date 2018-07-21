require 'russian_obscenity'

# Word class :/
class Word
  attr_reader :word

  def initialize(word)
    @word = word
  end

  def obscene?
    return true if RussianObscenity.obscene?(@word) || @word.include?('*')
    false
  end

  def to_lower
    @word.mb_chars.downcase!.to_s
  end

  def to_lower_symbol
    to_lower.to_sym
  end
end

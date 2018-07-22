require 'russian_obscenity'

# Word class :/
class Word < String
  attr_reader :word

  def initialize(word)
    @word = word
  end

  def obscene?
    RussianObscenity.obscene?(@word) || @word.include?('*')
  end

  def to_lower
    @word.mb_chars.downcase!.to_s
  end

  def to_lower_symbol
    to_lower.to_sym
  end
end

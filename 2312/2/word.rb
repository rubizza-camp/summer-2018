require 'russian_obscenity'

class Word
  attr_reader :word
  def initialize(word)
    @word = word
  end

  def obscene?
    word.include?('*') || RussianObscenity.obscene?(word)
  end
end

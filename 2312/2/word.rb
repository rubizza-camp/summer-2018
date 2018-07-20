require 'russian_obscenity'

# this class has only one function for now - to say if the word is obscene
class Word
  def initialize(word)
    @word = word
  end

  def obscene?
    @word.include?('*') || RussianObscenity.obscene?(@word)
  end
end

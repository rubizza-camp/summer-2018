require 'russian_obscenity'

# this class has only one function for now - to say if the word is obscene
class Word
  def self.obscene?(word)
    word.include?('*') || RussianObscenity.obscene?(word)
  end
end

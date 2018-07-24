require 'russian_obscenity'

class Word
  def self.bad_word(word)
    word.include?('*') || RussianObscenity.obscene?(word)
  end
end

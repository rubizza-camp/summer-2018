require 'russian_obscenity'

# Process each received word
class Word
  def self.bad_word(word)
    word.include?('*') || RussianObscenity.obscene?(word)
  end
end

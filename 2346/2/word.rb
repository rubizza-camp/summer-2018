require 'russian_obscenity'

module Rap
  class Word
    attr_reader :word

    def initialize(word)
      @word = word
    end

    def bad_word?
      RussianObscenity.obscene?(@word) || @word.include?('*')
    end

    def to_s
      word
    end
  end
end

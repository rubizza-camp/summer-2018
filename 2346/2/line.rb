require_relative 'word'

module Rap
  class Line
    attr_reader :words

    def initialize(line)
      @words = line.downcase.scan(/[ёа-яa-z\*]+/).map { |word| Word.new(word) }
    end

    def all_words
      @words
    end

    def bad_words
      @words.select(&:bad_word?)
    end
  end
end

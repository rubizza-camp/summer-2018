require_relative 'exception_array_for_top_words'
require_relative 'top_words_dictionary'

module Rap
  class TopWordsCounter
    attr_reader :dictionary, :exclude_array

    def initialize
      @dictionary = TopWordsDictionary.new
      @exclude_array = ExceptionArrayForTopWords.new
      @exclude_array.fill_with_exceptions
    end

    def count(rapper, quantity)
      words = rapper.fill_battles.all_words.flatten.map(&:to_s)
      words.each do |word|
        dictionary.push(word) unless exclude_array.include?(word)
      end
      dictionary.result(quantity)
    end
  end
end

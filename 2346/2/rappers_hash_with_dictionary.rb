require_relative 'base_rapper_hash'

module Rap
  class RappersHashWithDictionary
    include BaseRappersHash
    attr_reader :dict, :exclude_array

    def initialize
      @rappers_hash = {}
      fill_rapper_hash
      @dict = {}
      @exclude_array = []
    end

    def print_dictionary(quantity)
      dict.sort_by { |word| word[1] }.last(quantity).reverse_each { |elem| puts "\"#{elem[0]}\" - #{elem[1]} раз" }
    end

    def array_with_exceptions
      IO.foreach('./exceptions.txt') { |line| @exclude_array << line.delete("\n") }
    end

    def result_for_second(name, quantity)
      possible_key = find_rapper_key(name)
      if possible_key
        array_with_exceptions
        count_top_words(rappers_hash[possible_key], quantity)
      else
        unknown_rapper(name)
      end
    end

    def count_top_words(rapper, quantity)
      words = rapper.fill_battles.all_words.flatten.map(&:to_s)
      words.each do |word|
        unless exclude_array.include?(word)
          dict.key?(word) ? @dict[word] += 1 : @dict[word] = 1
        end
      end
      print_dictionary(quantity)
    end

    def unknown_rapper(name)
      puts "Рэпер #{name} мне не известен. Зато мне известны: "
      rappers_hash.keys.each { |key| puts key }
    end
  end
end

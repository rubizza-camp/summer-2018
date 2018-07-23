module Rap
  class TopWordsDictionary
    attr_reader :dict

    def initialize
      @dict = {}
    end

    def push(word)
      dict.key?(word) ? @dict[word] += 1 : @dict[word] = 1
    end

    def print(quantity)
      dict.sort_by { |word| word[1] }.last(quantity).reverse_each { |elem| puts "\"#{elem[0]}\" - #{elem[1]} раз" }
    end
  end
end

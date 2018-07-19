# Class for counting top words
class CountWords
  attr_reader :words, :value, :hash_words
  def initialize(words, value)
    @words = words.downcase.delete('.,!?—«»').split(' ').reject { |word| word.size < 5 }
    @value = value.zero? ? 30 : value
    @hash_words = {}
    group_words
  end

  def output_words
    hash_words[0...value].each { |elem| puts "#{elem[0]} - #{elem[1]} раз" }
  end

  private

  def group_words
    words.each do |word|
      @hash_words[word] = if hash_words.key?(word)
                            hash_words[word] + 1
                          else
                            1
                          end
    end
    @hash_words = hash_words.sort_by { |word| word[1] }.reverse!
  end
end

# Class for counting top words
class WordsCounter
  DEFAULT_MAX_WORDS = 30

  attr_reader :words, :value, :hash_words

  def initialize(words, value)
    @words = words.downcase.delete('.,!?—«»').split(' ').reject { |word| word.size < 5 }
    @value = value.zero? ? DEFAULT_MAX_WORDS : value
    @hash_words = {}
    group_words
  end

  def run
    hash_words[0...value].each { |elem| puts "#{elem[0]} - #{elem[1]} раз" }
  end

  private

  def group_words
    words.each do |word|
      check_word(word)
      @hash_words[word] += 1
    end
    @hash_words = hash_words.sort_by { |word| word[1] }.reverse!
  end

  def check_word(word)
    @hash_words[word] ||= 0
  end
end

require 'russian_obscenity'
# This class count words and bad words
class CountWords
  attr_reader :words, :number_words, :number_bad_words

  def initialize(words)
    @words = words
  end

  def call
    there_are_words?
    { number_words: number_words, number_bad_words: number_bad_words }
  end

  private

  def there_are_words?
    answer = Hash.new(proc { prepare_data })
    answer[nil] = proc { puts_zeros }
    answer[words].call
  end

  def prepare_data
    @number_words = words.size
    @number_bad_words = count
  end

  def puts_zeros
    @number_words = 0
    @number_bad_words = 0
  end

  def count
    counter = 0
    words.each do |word|
      counter += 1 if word.include? '*'
    end
    counter + RussianObscenity.find(words.join(' ')).size
  end
end

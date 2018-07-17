class WordControl
  attr_accessor :words

  def word_analysis(file, words_array)
    fill_array(file, words_array)
    words_array_pretty_view(words_array)
    words_often(words_array)
  end

  def words_array_pretty_view(array)
    array.flatten!
    array.map(&:downcase!)
  end

  def words_often(arr)
    arr.each do |word|
      new_word(word) unless search_in_words_array(word, @words)
      temp = @words.index(search_in_words_array(word, @words))
      @words[temp][word.to_sym] += 1
    end
  end

  def new_word(word)
    new_word = {}
    new_word[word.to_sym] = 0
    @words << new_word
  end
end 


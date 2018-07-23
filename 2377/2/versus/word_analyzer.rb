# Finds favourite words
class WordAnalyzer
  attr_reader :fav_words, :name

  def initialize(rapper)
    @fav_words = {}
    @dictionary = []
    @words = rapper.words
  end

  def sort_fav_words
    @fav_words = @fav_words.sort_by { |_key, value| -value }.to_h
  end

  def find_favourite_words
    fav_words_count
    sort_fav_words
  end

  def dictionary
    dict = File.readlines('dictionary.yml').inject { |str, line| str << line }
    @dictionary = dict.split
  end

  def prepared_words
    words = @words.map(&:downcase)
    words.map! { |word| word[/[A-Za-zА-Яа-яёЁ0-9\*]*/] }
    words.delete_if { |word| dictionary.include?(word) || word == '' }
  end

  def fav_words_count
    @fav_words = prepared_words.each_with_object(Hash.new(0)) { |word, hash| hash[word] += 1 }
  end
end

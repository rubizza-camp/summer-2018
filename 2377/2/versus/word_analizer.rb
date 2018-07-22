# Finds favourite words
class WordAnalizer
  attr_reader :fav_words, :name

  def initialize(battles)
    @fav_words = {}
    @dictionary = []
    @word_array = []
    @battles = battles
  end

  def sort_fav_words
    @fav_words = @fav_words.sort_by { |_key, value| -value }.to_h
  end

  def find_favourite_words(battle)
    word_array(battle)
    prepare_words
    @fav_words.merge!(fav_words_make) { |_key, first, second| first + second }
    sort_fav_words
  end

  def dictionary
    dict = File.readlines('dictionary.yml').inject { |str, line| str << line }
    return @dictionary = dict.split
  end

  def prepare_words
    @word_array.map!(&:downcase)
    @word_array.map! { |word| word[/[A-Za-zА-Яа-яёЁ0-9\*]*/] }
    @word_array.delete_if { |word| dictionary.include?(word) || word == ''}
  end

  def fav_words_make
    fav_words = Hash.new 0
    @word_array.each { |word| fav_words[word] += 1 }
    return fav_words
  end

  def word_array(battle)
    file = File.readlines(battle.filename).inject { |str, line| str << line }
    @word_array = file.split
  end

  def fav_words_count
    @battles.each do |battle|
      find_favourite_words(battle)
    end
    return @fav_words
  end
end

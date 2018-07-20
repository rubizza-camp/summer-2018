# Finds favourite words
class WordAnalizer
  attr_reader :fav_words, :name

  def initialize(rapper)
    @fav_words = {}
    @name = rapper.name
    @not_counting = []
  end

  def make_dictionary
    dict = File.readlines('dictionary.txt').inject { |str, line| str << line }
    @not_counting = dict.split
  end

  def sort_fav_words
    @fav_words = @fav_words.sort_by { |_key, value| -value }.to_h
  end

  # :reek:DuplicateMethodCall
  # :reek:TooManyStatements
  def find_favourite_words(battle)
    fav_words = Hash.new 0
    make_dictionary
    file = File.readlines(battle.filename).inject { |str, line| str << line }
    word_array = file.split
    prepare_words(word_array)
    word_array.each { |word| fav_words[word] += 1 }
    @fav_words.merge!(fav_words) { |_key, first, second| first + second }
    sort_fav_words
  end

  # :reek:FeatureEnvy
  # :reek:UtilityFunction
  def prepare_words(word_array)
    word_array.map!(&:downcase)
    word_array.map! { |word| word[/[A-Za-zА-Яа-яёЁ0-9\*]*/] }
    word_array.delete_if { |word| @not_counting.include?(word) }
  end
end

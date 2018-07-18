# This class keeps the information about rapper
# :reek:Attribute
# :reek:TooManyInstanceVariables
class Rapper
  attr_accessor :battles
  attr_reader :words_per_battle, :fav_words, :bad_words, :words_per_round, :name
  def initialize(filename)
    @name = filename[/((\w|\d|.|\s)*?)(?=против|[vV][Ss] )/]
    @bad_words = 0
    @rounds = 0
    @words = 0
    @words_per_round = 0
    @battles = 1
    @fav_words = {}
  end

  # :reek:UncommunicativeVariableName
  # :reek:TooManyStatements
  def count_bad_words(filename)
    exp = /\W*\*\W*/
    word_arr = []
    file_array = []
    read_file(filename, file_array)
    file_array.each do |line|
      word_arr += line.split
    end
    @bad_words += word_arr.count { |w| RussianObscenity.obscene?(w) || w[exp] }
  end

  # :reek:UtilityFunction
  # do with inject
  def read_file(filename, file_array)
    File.foreach filename do |line|
      file_array.push(line)
    end
  end

  # :reek:TooManyStatements
  def count_rounds_and_words(filename)
    exp = /((\d [Рр]аунд)|([Рр]аунд \d))(.|\w|\s)*/
    words_array = []
    file_array = []
    read_file(filename, file_array)
    count_rounds(file_array, exp)
    count_words(words_array, file_array, exp)
    rounds_check
  end

  def count_rounds(file_array, exp)
    rounds = file_array.count { |line| line[exp] }
    @rounds += rounds
  end

  # :reek:FeatureEnvy
  # :reek:TooManyStatements
  def count_words(words_array, file_array, exp)
    words = []
    words_array = file_array.delete_if { |line| line[exp] }
    words_array.each do |line|
      words += line.split
    end
    @words += words.size
  end

  def rounds_check
    @rounds = 1 if @rounds.zero?
  end

  def count_words_per_round(filename)
    count_rounds_and_words(filename)
    @words_per_round = @words / @rounds
  end

  def count_words_per_battle
    @words_per_battle = @bad_words / @battles
  end

  # divide in small methods somehow
  def sort_fav_words
    @fav_words = @fav_words.sort_by { |_key, value| -value }.to_h
  end

  # :reek:DuplicateMethodCall
  # :reek:TooManyStatements
  def find_favourite_words(filename)
    fav_words = Hash.new 0
    word_array = []
    buf = []
    not_counting = []
    read_file('simple_words_dictionary.txt', buf)
    buf.each do |line|
      not_counting += line.split
    end
    File.foreach filename do |line|
      word_array += line.split
    end
    prepare_words(word_array, not_counting)
    word_array.each { |word| fav_words[word] += 1 }
    @fav_words.merge!(fav_words) { |_key, first, second| first + second }
    sort_fav_words
  end

  # :reek:UtilityFunction
  def prepare_words(word_array, not_counting)
    word_array.map!(&:downcase)
    word_array.map! { |word| word[/[A-Za-zА-Яа-яёЁ0-9\*]*/] }
    word_array.delete_if { |word| not_counting.include?(word) }
  end
end

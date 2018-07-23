# This class keeps the data of one battle
class Battle
  Exp = /((\d [Рр]аунд)|([Рр]аунд \d))(.|\w|\s)*/
  attr_reader :filename, :words
  def initialize(filename)
    @filename = filename
    @line_array = line_array
    @words = words_make(filename)
  end

  def line_array
    @line_array ||= File.readlines(@filename).inject([]) { |arr, ln| arr << ln }
  end

  def count_words_per_round
    rounds = count_rounds
    count_words / rounds
  end

  #:reek:FeatureEnvy
  def count_words
    words_array = line_array.delete_if { |line| line[Exp] }
    (words_array.inject([]) { |arr, line| arr + line.split }).size
  end

  def words_make(filename)
    words = File.read(filename)
    return @words = words.split
  end

  def count_rounds
    rounds = @line_array.count { |line| line[Exp] }
    rounds = 1 if rounds.zero?
    rounds
  end

  def count_bad_words
    exp = /\W*\*\W*/
    file = File.read(@filename)
    words = file.split
    words.count { |word| RussianObscenity.obscene?(word) || word[exp] }
  end
end

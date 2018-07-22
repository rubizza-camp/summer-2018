# This class keeps the data of one battle
class Battle
  attr_reader :filename
  def initialize(filename)
    @filename = filename
    @line_array = line_array
  end

  def make_line_array
    @line_array = File.readlines(@filename).inject([]) { |arr, ln| arr << ln }
  end

  def line_array
    @line_array ||= make_line_array
  end

  def count_words_per_round
    exp = /((\d [Рр]аунд)|([Рр]аунд \d))(.|\w|\s)*/
    rounds = count_rounds(exp)
    count_words(exp) / rounds
  end

  #:reek:FeatureEnvy
  def count_words(exp)
    words_array = @line_array.delete_if { |line| line[exp] }
    (words_array.inject([]) { |arr, line| arr + line.split }).size
  end

  def count_rounds(exp)
    rounds = @line_array.count { |line| line[exp] }
    rounds = 1 if rounds.zero?
    rounds
  end

  def count_bad_words
    exp = /\W*\*\W*/
    file = File.read(@filename)
    w_arr = file.split
    w_arr.count { |www| RussianObscenity.obscene?(www) || www[exp] }
  end
end

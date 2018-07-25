# This class keeps the data of one battle
class Battle
  REGEXP = /((\d [Рр]аунд)|([Рр]аунд \d))(.|\w|\s)*/
  attr_reader :filename
  def initialize(filename)
    @filename = filename
    @line_array = line_array
    @words = words
  end

  def line_array
    @line_array ||= File.readlines(@filename).inject([]) { |arr, ln| arr << ln }
  end

  def count_words_per_round
    rounds = count_rounds
    count_words / rounds
  end

  def count_words
    @words.count
  end

  def words
    @words ||= File.read(@filename).split
  end

  def count_rounds
    rounds = line_array.count { |line| line[REGEXP] }
    rounds = 1 if rounds.zero?
    rounds
  end

  def count_bad_words
    expression = /\W*\*\W*/
    words.count { |word| RussianObscenity.obscene?(word) || word[expression] }
  end
end

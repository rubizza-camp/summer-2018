# This class keeps the data of one battle
class Battle
  attr_reader :words_per_round, :filename
  def initialize(filename)
    @filename = filename
    @line_array = make_line_array
    @words_per_round = 0
    @rounds = 0
  end

  def make_line_array
    @line_array = []
    File.foreach @filename do |line|
      @line_array.push(line)
    end
    @line_array
  end

  def count_words_per_round
    exp = /((\d [Рр]аунд)|([Рр]аунд \d))(.|\w|\s)*/
    count_rounds(exp)
    words = count_words(exp)
    @words_per_round = words / @rounds
  end

  def count_rounds(exp)
    @rounds = @line_array.count { |line| line[exp] }
    @rounds = 1 if @rounds.zero?
  end

  def count_words(exp)
    words = []
    words_array = @line_array.delete_if { |line| line[exp] }
    words_array.inject(words) { |words, line| words += line.split }
    words.size
  end
end

# #In this class, an array of data is created for the RaperArray class.
# Here information accumulates participants for all battles
class Sum
  # The number of all words in all of the battles
  # This method smells of :reek:TooManyStatements
  def self.all_col_word(total_words_array, _top_words)
    @text_sum = []
    @count_word_all_round = 0
    @numb_round = 0
    (0..total_words_array.length - 1).step(3) do |col|
      @count_word_all_round += total_words_array[col]
      @numb_round += 1
    end
  end

  # The number of all bad words in all of the rounds
  def self.all_col_bad_word(total_words_array, _top_words)
    @count_bad_word_all_round = 0
    (1..total_words_array.length - 1).step(3) do |col|
      @count_bad_word_all_round += total_words_array[col]
    end
  end

  # All the words in all the battles for the participant
  # This method smells of :reek:TooManyStatements
  def self.all_words(total_words_array, _top_words)
    hashtext = Hash.new(0)
    (2..total_words_array.length - 1).step(3) do |col|
      @text_sum += total_words_array[col]
    end
    @text_sum.each { |col| hashtext[col] += 1 if col.length > 4 }
    @text_sum = hashtext.sort_by { |_name, age| age }.sort! do |col, col_n|
      col_n[1] <=> col[1]
    end
  end

  # This method smells of :reek:TooManyStatements
  def self.sum(total_words_array, top_words)
    arr_new = []
    all_col_word(total_words_array, top_words)
    all_col_bad_word(total_words_array, top_words)
    all_words(total_words_array, top_words)
    (0...top_words).step(1) { |count| @text_sum += @text_sum[count] }
    # Number of words per battle
    num_words_per_battle = @count_bad_word_all_round / @numb_round.to_f
    # Rounding up to two characters after the point
    num_w_bat = num_words_per_battle.round 2
    # Average number of words in a raund
    num_words = @count_word_all_round / @numb_round
    arr_new.push(@numb_round, @count_bad_word_all_round,
                 num_w_bat, num_words, @text_sum)
  end
end

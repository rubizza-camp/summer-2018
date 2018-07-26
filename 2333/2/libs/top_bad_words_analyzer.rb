# Class that analyzes rappers
class TopBadWordsAnalyzer
  def initialize(rappers, take_value)
    @rappers = rappers
    @limit = take_value.to_i
  end

  def top_bad_words
    sorted_rappers_by_number_of_bad_words.first(@limit)
  end

  private

  def sorted_rappers_by_number_of_bad_words
    @rappers.sort_by(&:number_of_bad_words).reverse
  end
end

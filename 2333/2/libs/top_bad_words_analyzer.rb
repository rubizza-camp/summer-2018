require_relative './top_bad_words_printer.rb'

# Class that analyzes rappers
class TopBadWordsAnalyzer
  def initialize(rappers, take_value)
    @rappers = rappers
    @limit = take_value.to_i
  end

  def top_bad_words
    TopBadWordsPrinter.new(top_sorted_rappers).print_top_bad_words
  end

  private

  def top_sorted_rappers
    sorted_rappers_by_number_of_bad_words.first(@limit)
  end

  def sorted_rappers_by_number_of_bad_words
    @rappers.sort_by(&:number_of_bad_words).reverse
  end
end

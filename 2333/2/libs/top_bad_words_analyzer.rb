require_relative 'handler'
require 'terminal-table'
require_relative './analyzer_printer.rb'
require_relative './names_searcher.rb'

# VersusBattle text analyzer
class TopBadWordsAnalyzer
  def initialize(rappers, take_value)
    @rappers = rappers
    @limit = take_value.to_i
  end

  def top_bad_words
    AnalyzerPrinter.print_top_bad_words(top_sorted_rappers)
  end

  private

  def top_sorted_rappers
    sorted_rappers_by_number_of_bad_words.first(@limit)
  end

  def sorted_rappers_by_number_of_bad_words
    @rappers.sort_by(&:number_of_bad_words).reverse
  end
end

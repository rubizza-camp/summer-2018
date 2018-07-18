require_relative 'handler'
require 'terminal-table'
require_relative './analyzer_printer.rb'
require_relative './names_searcher.rb'

# VersusBattle text analyzer
class TopBadWordsAnalyzer
  def initialize(rappers, take_value)
    @rappers = rappers
    @take_value = take_value.to_i
  end

  def top_bad_words
    AnalyzerPrinter.print_top_bad_words(analyze_rappers)
  end

  private

  def analyze_rappers
    result = []
    @rappers.first(@take_value).each do |rapper|
      result << rapper.stats
    end
    result.sort_by! { |rapper| rapper[3] }.reverse!
  end
end

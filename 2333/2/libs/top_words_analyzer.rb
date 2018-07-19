require_relative 'handler'
require 'terminal-table'
require_relative './analyzer_printer.rb'
require_relative './names_searcher.rb'

# VersusBattle text analyzer
# :reek:ControlParameter
class TopWordsAnalyzer
  def initialize(rappers, selected_name, take_value)
    @rappers = rappers
    @name = selected_name
    @take_value = take_value || 30
  end

  def top_words
    exit unless names_include_name?
    counter = texts_wo_stopwords.each_with_object(Hash.new(0)) { |word, hash| hash[word.downcase] += 1 }
    AnalyzerPrinter.print_top_words(counter, @take_value)
  end

  private

  def names_include_name?
    names_searcher = NamesSearcher.new(@rappers, @name)
    names_searcher.search_name
  end

  def texts_wo_stopwords
    Handler.delete_prepositions(@rappers, @name)
  end
end

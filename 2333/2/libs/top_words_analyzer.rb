require_relative 'handler'
require 'terminal-table'
require_relative './analyzer_printer.rb'
require_relative './names_searcher.rb'

# VersusBattle text analyzer
class TopWordsAnalyzer
  def initialize(rappers, take_value, selected_name)
    @rappers = rappers
    @take_value = take_value.to_i
    @name = selected_name
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

require_relative 'handler'
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
    AnalyzerPrinter.print_rappers_names(names, @name) unless names_include_name?
    AnalyzerPrinter.print_top_words(hash_of_top_words, @take_value)
  end

  private

  def hash_of_top_words
    texts_wo_stopwords.each_with_object(Hash.new(0)) { |word, hash| hash[word.downcase] += 1 }
  end

  def names_include_name?
    NamesSearcher.new(@rappers, @name).search_name
  end

  def texts_wo_stopwords
    Handler.delete_prepositions(@rappers, @name)
  end
end

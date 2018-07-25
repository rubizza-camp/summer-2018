require_relative './top_words_printer.rb'

# Class that analyzes rappers
# :reek:ControlParameter
class TopWordsAnalyzer
  def initialize(rappers, selected_name, take_value)
    @rappers = rappers
    @name = selected_name
    @take_value = take_value || 30
  end

  def top_words
    TopWordsPrinter.new(hash_of_top_words, @take_value).print_top_words
  end

  private

  def hash_of_top_words
    texts_wo_stopwords.each_with_object(Hash.new(0)) { |word, hash| hash[word.downcase] += 1 }
  end

  def texts_wo_stopwords
    @rappers.select { |rapper| rapper.name == @name }.first.delete_stopwords_from_texts
  end
end

require_relative './top_words_printer.rb'

# Class that analyzes rappers
class TopWordsAnalyzer
  def initialize(rappers, selected_name)
    @rappers = rappers
    @name = selected_name
  end

  def top_words
    texts_wo_stopwords.each_with_object(Hash.new(0)) { |word, hash| hash[word.downcase] += 1 }
  end

  private

  def texts_wo_stopwords
    @rappers.select { |rapper| rapper.name == @name }.first.delete_stopwords_from_texts
  end
end

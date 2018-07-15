require_relative 'handler'
require 'terminal-table'
require_relative './analyzer_printer.rb'
require_relative './names_searcher.rb'

# VersusBattle text analyzer
class Analyzer
  def initialize(rappers, take_value = nil, selected_name = nil)
    @rappers = rappers
    @take_value = take_value.to_i
    @name = selected_name
  end

  def top_bad_words
    AnalyzerPrinter.print_top_bad_words(analyze_rappers)
  end

  def top_words
    exit unless names_include_name?
    texts = Handler.delete_prepositions(@rappers, @name)
    counter = texts.each_with_object(Hash.new(0)) { |word, count| count[word.upcase] += 1 }
    AnalyzerPrinter.print_top_words(counter, @take_value)
  end

  private

  def names_include_name?
    names_searcher = NamesSearcher.new(@rappers, @name)
    names_searcher.search_name
  end

  def sort_by_mats(rappers)
    rappers.sort_by! { |rapper| rapper[3] }.reverse!
  end

  def add_rapper_info(rapper)
    [rapper.name, rapper.battles.count, rapper.all_mats, rapper.mats_on_battle, rapper.words_on_round]
  end

  def analyze_rappers
    result = []
    @rappers.first(@take_value).each do |rapper|
      result << add_rapper_info(rapper)
    end
    sort_by_mats(result)
  end
end

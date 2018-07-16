require './rapper_parser.rb'
require './top_words_statistic.rb'

# This class create hash with rapper-bad_words_count to show stats
class BadWordsCounter
  def self.search_bad_words
    RapperParser.new.list.each_with_object(Hash.new(0)) do |name, bad_words_count|
      bad_words_count[name] = WordsCounter.new(name).bad_words_count
    end
  end

  def self.sorting_bad_words
    search_bad_words.sort_by { |bad_words_count| bad_words_count[1] }.reverse
  end
end

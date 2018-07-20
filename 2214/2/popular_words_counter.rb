require_relative 'word_with_quantity'
require_relative 'battler'

class PopularWordsCounter
  PREPOSITIONS_FILE = 'Предлоги'.freeze
  def initialize(specific_battler, top_words)
    @battles = specific_battler.battles
    @top_words = top_words
  end

  def count
    popular_words.first(@top_words).map { |popular_word| puts "#{popular_word.word} - #{popular_word.quantity} раз" }
  end

  private

  def popular_words
    words.uniq.map { |word| WordWithQuantity.new(word, words.count(word)) }.sort_by(&:quantity).reverse
  end

  def words
    all_words = files.gsub(/[\p{P}]/, ' ').downcase.strip.split
    all_words.reject { |word| File.read(PREPOSITIONS_FILE).split("\n").include? word }
  end

  def files
    @battles.map(&:text).join(' ')
  end
end

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
    @popular_words ||= words_with_quantity.sort_by(&:quantity).reverse
  end

  def words_with_quantity
    @words_with_quantity ||= uniq_usefull_words.map { |word| WordWithQuantity.new(word, usefull_words.count(word)) }
  end

  def uniq_usefull_words
    @uniq_usefull_words ||= usefull_words.uniq
  end

  def usefull_words
    @usefull_words ||= all_words.reject { |word| prepositions.include? word }
  end

  def all_words
    @all_words ||= files.gsub(/[\p{P}]/, ' ').downcase.strip.split
  end

  def files
    @files ||= @battles.map(&:text).join(' ')
  end

  def prepositions
    File.read(PREPOSITIONS_FILE).split("\n")
  end
end

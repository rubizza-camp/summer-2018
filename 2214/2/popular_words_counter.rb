require_relative 'word_with_quantity'
require_relative 'battles_by_name_giver'

class PopularWordsCounter
  include BattlesByNameGiver
  PREPOSITIONS_FILE = 'Предлоги'.freeze
  def initialize(battles, battler_name, top_words)
    @battles = battles
    @battler_name = battler_name
    @top_words = top_words
  end

  def count
    popular_words[0...@top_words].map { |popular_word| puts "#{popular_word.word} - #{popular_word.quantity} раз" }
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
    BattlesByNameGiver.take(@battles, @battler_name).map(&:text).join(' ')
  end
end

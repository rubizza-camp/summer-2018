require_relative 'word_with_quantity'

class PopularWordsCounter
  PREPOSITIONS_FILE = 'Предлоги'.freeze
  def self.count(battles, battler_name, top_words)
    files = battles_of_battler(battles, battler_name).map(&:text).join(' ')
    show_popular_words(top_words, find_popular_words(get_words(files)))
  end

  def self.get_words(file)
    words = file.gsub(/[\p{P}]/, ' ').downcase.strip.split
    words.reject { |word| File.read(PREPOSITIONS_FILE).split("\n").include? word }
  end

  def self.find_popular_words(words)
    words.uniq.map { |word| WordWithQuantity.new(word, words.count(word)) }.sort_by!(&:quantity).reverse!
  end

  def self.show_popular_words(top_words, popular_words)
    top_words.times { |ind| puts "#{popular_words[ind].word} - #{popular_words[ind].quantity} раз" }
  end

  def self.battles_of_battler(battles, battler_name)
    battles.select { |battle| battle.title.split('против').first.include? battler_name }
  end
end

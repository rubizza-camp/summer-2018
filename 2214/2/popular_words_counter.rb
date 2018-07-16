require_relative 'word_with_quantity'

class PopularWordsCounter
  PREPOSITIONS_FILE = 'Предлоги'.freeze
  def self.count(battles, battler_name, top_words)
    files = ''
    battles.each do |battle|
      files += battle.text if battle.title.split('против').first.include? battler_name
    end
    show_popular_words(top_words, find_popular_words(get_words(files)))
  end

  def self.get_words(file)
    file.downcase!.strip!
    words = file.gsub(/[.,!?:;«»<>&'()]/, ' ').split
    words.each { |word| words.delete(word) if File.read(PREPOSITIONS_FILE).split("\n").include? word }
    words
  end

  def self.find_popular_words(words)
    words_with_quantity = []
    words.uniq.each { |word| words_with_quantity << WordWithQuantity.new(word, words.count(word)) }
    words_with_quantity.sort_by!(&:quantity).reverse!
    words_with_quantity
  end

  def self.show_popular_words(top_words, popular_words)
    top_words.times { |ind| puts "#{popular_words[ind].word} - #{popular_words[ind].quantity} раз" }
  end
end

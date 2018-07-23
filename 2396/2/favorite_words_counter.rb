# This is class FavoriteWordsCounter
class FavoriteWordsCounter
  include Helper
  FILE_PRONOUNS = 'pronouns.json'.freeze
  PRONOUNS      = JSON.parse(File.read(FILE_PRONOUNS))
  def initialize(raper, top_words)
    @battles = raper.battles
    @top_words = top_words
  end

  def show
    favorite_words.first(@top_words).map do |favorite_word|
      puts "#{favorite_word.word} - #{favorite_word.quantity} раз"
    end
  end

  private

  def favorite_words
    correct_words.uniq.map do |word|
      WordWithQuantity.new(word, correct_words.count(word))
    end.sort_by(&:quantity).reverse
  end

  def correct_words
    words = (all_words - PRONOUNS).join(' ')
    Helper.clearing_text_from_garbage(words)
  end

  def all_words
    files.tr("\n", ' ').downcase.strip.split
  end

  def files
    @battles.map(&:text).join(' ')
  end
end

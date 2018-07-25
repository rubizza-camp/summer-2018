require_relative 'WordWithQuantity'
require_relative 'Participant'
# Class find most popular words of one participant
class PopularWords
  def initialize(battles, top_words)
    @battles = battles
    @top_words = top_words
  end

  def count
    popular_words.first(@top_words)
                 .map { |word| "#{word.word} - #{word.quantity} раз" }
  end

  private

  def popular_words
    @popular_words ||= words_with_quantity.sort_by(&:quantity).reverse
  end

  def words_with_quantity
    @words_with_quantity ||= uniq_usefull_words.map do |word|
      WordWithQuantity
        .new(word, usefull_words.count(word))
    end
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
    @files ||= @battles.map(&:words).join(' ')
  end

  def prepositions
    @prepositions ||= File.read('Предлоги.yaml')
  end
end

# class Rapper
class Rapper
  attr_reader :name, :battles
  ROUNDS_ON_BATTLE = 3

  def initialize(name, battles)
    @name = name
    @battles = battles
    RussianObscenity.dictionary = [:default, './my_dictionary.yml']
  end

  def number_of_bad_words
    @number_of_bad_words ||= unique_bad_words.map { |word| battles_words.count(word) }.reduce(:+)
  end

  def battles_words
    @battles_words ||= @battles.join(' ').split(/[^[а-яА-Я*ёЁa-zA-Z]]+/)
  end

  def bad_words_on_battle
    (number_of_bad_words / @battles.count.to_f).round(2)
  end

  def words_on_round
    battles_words.count / (@battles.count * ROUNDS_ON_BATTLE)
  end

  def delete_stopwords_from_texts
    prepositions = File.read('prepositions.txt').split(',').map!(&:upcase)
    battles_words.reject! { |word| prepositions.include?(word.upcase) }
  end

  private

  def unique_bad_words
    @unique_bad_words ||= RussianObscenity.find(@battles.join(' '))
  end
end

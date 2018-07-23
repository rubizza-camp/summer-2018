require 'russian_obscenity'

# This class analyzes the texts of the participants.
class TextHandler
  attr_reader :battle_count, :bad_words, :words_count, :rounds_count

  def initialize
    @battle_count = 0
    @bad_words = 0
    @words_count = 0
    @rounds_count = 0
  end

  def work_with_text(filename)
    text = File.read(filename)
    words = WordsHundler.new.counting_words(text)
    @words_count += words.size
    @bad_words = counting_bad_words(words)
    @rounds_count = counting_rounds(text)
  end

  def counting_bad_words(words)
    @bad_words += words.count do |word|
      word.include?('*') || RussianObscenity.obscene?(word)
    end
  end

  def counting_rounds(text)
    @battle_count += 1
    rounds_count = text.scan(/(раунд)\s?\d/i).size
    @rounds_count += rounds_count.zero? ? 1 : rounds_count
  end
end

# :reek:DuplicateMethodCall
# :reek:UtilityFunction
# Description class
class WordsHundler
  def counting_words(text)
    words = text.scan(/[а-яА-ЯёЁ*]+/)
    words.reject { |el| el == '***' }
  end

  def words_battle(rapper)
    (rapper[1].bad_words.to_f / rapper[1].battle_count).round(1)
  end

  def words_round(rapper)
    (rapper[1].words_count / rapper[1].rounds_count.to_f).round(1)
  end

  def slovo(num)
    Russian.p(num, 'слово', 'слова', 'слов', 'слова')
  end

  def battle(num)
    Russian.p(num, 'батл', 'батла', 'батлов')
  end
end

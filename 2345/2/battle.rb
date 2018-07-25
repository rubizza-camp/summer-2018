require 'russian_obscenity'

# Collecting info about battles
class Battle
  def initialize(filename)
    @filename = filename
  end

  def bad_words_count
    words.count do |word|
      word.include?('*') || RussianObscenity.obscene?(word)
    end
  end

  def words_count
    words.count
  end

  def rounds_count
    round_word_in_text_count.zero? ? 1 : round_word_in_text_count
  end

  def round_word_in_text_count
    @round_word_in_text_count ||= text.scan(/(раунд)\s?\d/i).size
  end

  private

  def text
    @text ||= File.read(@filename)
  end

  def words
    @words ||= text.scan(/[\wа-яА-ЯёЁ*]+/).tap do |words|
      words.reject(&'***'.method(:==))
    end
  end
end

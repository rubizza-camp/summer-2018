require 'pry'

# Class one battle
class Battle
  def initialize(title)
    @title = title
  end

  OBSCENE_WORDS = File.read('bad_words').split(', ')

  def bad_words_count
    @bad_words_count ||= words.count { |word| word.include?('*') || OBSCENE_WORDS.include?(word) }
  end

  def sum_all_words
    @sum_all_words ||= words.count
  end

  def words
    @words ||= File.read(@title).downcase.scan(/[а-яёa-z*]+/)
  end
end

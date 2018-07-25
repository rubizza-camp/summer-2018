# Round class :/
class Round
  attr_reader :words

  def initialize
    @words = []
  end

  def add_word(word_obj)
    word_obj.is_a?(Word) ? @words << word_obj : raise(VersusExceptions::VersusObjectError, word_obj)
  end

  def words_number
    @words.count
  end

  def obscene_words_number
    obscene_words.count
  end

  def obscene_words
    @words.select(&:obscene?)
  end
end

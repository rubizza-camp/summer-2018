# Round class :/
class Round
  attr_reader :words

  def initialize
    @words = []
  end

  def add_word(word_obj)
    word_obj.is_a?(Word) ? @words << word_obj : raise(RoundObjectError, word_obj)
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

# Exception, that is raised when Round#add_word takes not a Word object
class RoundObjectError < StandardError
  def initialize(obj, message = default_message)
    @obj = obj
    @message = message
  end

  private

  def default_message
    'Error. given object is not is not an object of Word'
  end
end

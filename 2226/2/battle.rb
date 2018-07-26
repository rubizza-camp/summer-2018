# This class is used to process rapper data
class Battle
  SWEAR_WORDS = YAML.load_file('config.yml')['SWEAR_WORDS_ARRAY'].join('|')

  def initialize(text)
    @text = text
  end

  def number_of_swear_words
    @text.scan(/#{SWEAR_WORDS}/).size
  end

  def number_of_words_in_rounds
    @text.split(/ [а-яА-ЯёЁ*]+/).size
  end

  def number_of_rounds
    rounds = @text.scan(/Раунд \w/).size
    rounds.zero? ? 1 : rounds
  end

  def average_number_words_in_round
    number_of_words_in_rounds / number_of_rounds
  end
end

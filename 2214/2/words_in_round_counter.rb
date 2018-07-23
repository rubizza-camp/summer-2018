class WordsInRoundCounter
  ROUNDS_IN_BATTLE = 3
  def initialize(battles)
    @battles = battles
  end

  def count
    number_of_words / (@battles.size * ROUNDS_IN_BATTLE)
  end

  private

  def number_of_words
    @battles.map(&:text).join(' ').gsub(/[\p{P}]/, ' ').split.count
  end
end

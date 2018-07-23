class BadWordsAnalyzer
  attr_reader :battle, :words, :rounds

  def initialize(battle, words, rounds)
    @battle = battle
    @words = words
    @rounds = rounds
  end

  def analyze_bad
    bad_words_count = words.select do |word|
      word.include?('*') || word.include?('(.') ||
        RussianObscenity.obscene?(word)
    end .size
    [battle.size, bad_words_count, make_bad_words_in_battle(bad_words_count),
     make_words_in_round]
  end

  private

  def make_bad_words_in_battle(bad_words_count)
    bad_words_count / battle.size
  end

  def make_words_in_round
    words.size.div(rounds)
  end
end

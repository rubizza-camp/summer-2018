class BadWordsAnalyzer
  def initialize(battle, words)
    @battle = battle
    @words = words
  end

  def analyze_bad
    bad_words_count = @words.select do |word|
      word.include?('*') || word.include?('(.') ||
        RussianObscenity.obscene?(word)
    end .size
    [@battle.size, bad_words_count, bad_words_count / @battle.size,
     @words.size.div(make_round_num)]
  end

  private

  def make_round_num
    num = @battle.map { |_key, battle_text| battle_text.scan(/Раунд [1|2|3][^\s]*/).size }.sum
    num = 1 if num.zero?
    num
  end
end

class BadWordsAnalyzer
  def initialize(battle)
    @battle = battle
  end

  def analyze_bad
    words = divide_into_words
    words_count = words.size
    bad_words_count = BadWordsAnalyzer.count_bad_words(words)
    [@battle.size, bad_words_count, bad_words_count / @battle.size,
     words_count.div(make_round_num)]
  end

  def self.count_bad_words(words)
    words.select! { |word| word.include?('*') || word.include?('(.') || RussianObscenity.obscene?(word) }.size
  end

  private

  def make_round_num
    num = @battle.map { |_key, battle_text| battle_text.scan(/Раунд [1|2|3][^\s]*/).size }.inject(0) do |sum, el|
      sum + el
    end
    num = 1 if num.zero?
    num
  end

  def divide_into_words
    words = []
    @battle.each_value { |battle_text| words += select_words(battle_text) }
    words
  end

  def select_words(text)
    text = text.split(' ').select! { |word| word.match(/[^\s]+[a-zA-Z]*[а-яА-я]*[^\s]+/) }
    text.map { |word| word.gsub(/[,:;.?!«»]|&quot/, '') }
  end
end

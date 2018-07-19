class BadWordsAnalyzer
  # initialize all criterias for the table
  def initialize(battles)
    @battles = battles
    @round_num = 0
    @words = divide_into_words
  end

  def analyze_bad
    word_size = @words.size
    bad_words_counter = BadWordsAnalyzer.count_bad_words(@words)
    @round_num = 1 if @round_num.zero?
    [@battles.size, bad_words_counter, bad_words_counter / @battles.size,
     word_size.div(@round_num)]
  end

  def self.count_bad_words(words)
    words.select! { |word| word.include?('*') || word.include?('(.') || RussianObscenity.obscene?(word) }.size
  end

  private

  def divide_into_words
    words = []
    @battles.each do |_key, battle_text|
      @round_num += battle_text.scan(/Раунд [1|2|3][^\s]*/).size
      words += select_words(battle_text)
    end
    words
  end

  def select_words(text)
    text = text.split(' ').select! { |word| word.match(/[^\s]+[a-zA-Z]*[а-яА-я]*[^\s]+/) }
    text.map! { |word| word.gsub(/[,:;.?!«»]|&quot/, '') }
  end
end

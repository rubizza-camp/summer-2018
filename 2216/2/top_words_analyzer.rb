class TopWordsAnalyzer
  def initialize(battles, top_number)
    @battles = battles
    @output_num = top_number
    @words = divide_into_words
  end

  def analyze_top
    counts = {}
    make_counts(counts)
    counts = counts.sort_by { |_key, value| value }.reverse
    output_words(counts)
  end

  def self.print_top_words(word_with_count)
    puts "#{word_with_count[0]} - #{word_with_count[1]} раз"
  end

  private

  def make_counts(counts)
    @words.each { |word| @words.delete(word) if word.size < 5 || !noun?(word) }
    @words.reject(&:nil?).map! { |word| counts[word] = @words.count(word) unless counts.include?(word) }
  end

  def divide_into_words
    words = []
    @battles.each { |_key, battle_text| words += select_words(battle_text) }
    words
  end

  def select_words(text)
    text = Unicode.downcase(text).split(' ').select! { |word| word.match(/[^\s]+[a-zA-Z]*[а-яА-я]*[^\s]+/) }
    text.map! { |word| word.gsub(/[,:;.?!«»]|&quot/, '') }
  end

  def noun?(word)
    noun_qualifier = false
    endings_of_noun = %w[а ев ов ье иями ями ами еи ии и ией ей ой
                         ий й иям ям ием ем ам ом о у ах иях ях ы
                         ь ию ью ю ия ья я ок мва яна ровать ег ги
                         га сть сти]

    set_noun_qualifier(noun_qualifier, endings_of_noun, word)
  end

  def set_noun_qualifier(noun_qualifier, endings_of_noun, word)
    endings_of_noun.each do |noun_ending|
      noun_qualifier = same_endings?(noun_ending, word)
      break if noun_qualifier
    end
    noun_qualifier
  end

  def same_endings?(noun_ending, word)
    word[word.size - noun_ending.size..-1] == noun_ending
  end

  def output_words(counts)
    @output_num.times do
      word_with_count = counts.shift
      TopWordsAnalyzer.print_top_words(word_with_count)
    end
  end
end

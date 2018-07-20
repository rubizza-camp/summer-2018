class TopWordsAnalyzer
  def initialize(battles, top_number)
    @battles = battles
    @output_num = top_number
    @words = divide_into_words
  end

  def analyze_top
    counts = make_counts
    counts = counts.sort_by { |_key, value| value }.reverse
    output_words(counts)
  end

  def self.print_top_words(word_with_count)
    puts "#{word_with_count[0]} - #{word_with_count[1]} раз"
  end

  private

  def make_counts
    counts = {}
    @words.select { |word| word.size > 4 }.each do |word|
      counts[word] = @words.count(word) unless counts.include?(word)
    end
    counts
  end

  def divide_into_words
    @battles.map { |_key, battle_text| select_words(battle_text) }.flatten
  end

  def select_words(text)
    text = Unicode.downcase(text).split(' ').select! { |word| word.match(/[^\s]+[a-zA-Z]*[а-яА-я]*[^\s]+/) }
    text.map! { |word| word.gsub(/[,:;.?!«»]|&quot/, '') }
  end

  def output_words(counts)
    @output_num.times do
      word_with_count = counts.shift
      TopWordsAnalyzer.print_top_words(word_with_count)
    end
  end
end

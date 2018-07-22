class TopWordsAnalyzer
  def initialize(battles, words)
    @battles = battles
    @words = words
  end

  def analyze_top
    make_counts_of_top_words.sort_by { |_key, value| value }.reverse
  end

  private

  def make_counts_of_top_words
    counts_of_top_words = {}
    @words.select { |word| word.size > 4 }.each do |word|
      counts_of_top_words[word] = @words.count(word) unless counts_of_top_words.include?(word)
    end
    counts_of_top_words
  end
end

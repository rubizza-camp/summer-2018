# Class that produces output from TopWordsAnalyzer
# :reek:ControlParameter
class TopWordsPrinter
  def initialize(top_words, put_count)
    @top_words = top_words
    @put_count = put_count || 30
  end

  def print_top_words
    @top_words.sort_by { |_word, count| count }.reverse!
    @top_words.first(@put_count.to_i).each do |word, count|
      puts "#{word} : #{count}"
    end
  end
end

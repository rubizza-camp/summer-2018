# This class is needed to find most popular words from text files
class TopWord
  attr_reader :battler

  def initialize(battler)
    @battler = battler
    @words = []
    @top_words = {}
  end

  def dir_count
    Dir[File.join("./rap-battles/#{@battler}/", '**', '*')].count { |file| File.file?(file) }
  end

  # This method smells of :reek:NestedIterators
  def check_all_words
    1.upto(dir_count) do |text|
      File.new("./rap-battles/#{@battler}/#{text}").each do |line|
        line.split.each do |word|
          word = word.delete '.', ',', '?»', '&quot', '!', ';'
          @words << word
        end
      end
    end
  end

  # This method smells of :reek:DuplicateMethodCall
  # This method smells of :reek:TooManyStatements
  def top_words_counter
    pretexts = []
    File.new('./pretexts').each { |line| pretexts << line.delete("\n") }
    while @words.any?
      counter = 0
      @words.each { |word| counter += 1 if word == @words[0] && !pretexts.include?(word) }
      @top_words[@words[0]] = counter
      @words.delete(@words[0])
    end
  end

  # This method smells of :reek:DuplicateMethodCall
  def res(value)
    @top_words = @top_words.sort_by { |_key, val| val }
    @top_words = @top_words.reverse
    0.upto(value - 1) { |index| puts @top_words[index][0] + ' - ' + @top_words[index][1].to_s + ' раз(а)' }
  end
end

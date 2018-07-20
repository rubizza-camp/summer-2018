# This class is needed to find most popular words from text files
class TopWord
  attr_reader :battler

  def initialize(battler)
    @battler = battler
    @pretexts = []
    @words = []
    @top_words = {}
  end

  def dir_count
    Dir[File.join("./rap-battles/#{@battler}/", '**', '*')].count { |file| File.file?(file) }
  end

  def clear_words(line)
    line.split.each do |word|
      word = word.delete '.', ',', '?»', '&quot', '!', ';'
      @words << word
    end
  end

  def check_words_in_text(text)
    File.new("./rap-battles/#{@battler}/#{text}").each do |line|
      clear_words(line)
    end
  end

  def check_all_words
    1.upto(dir_count) do |text|
      check_words_in_text(text)
    end
  end

  def pretexts_value
    File.new('./pretexts').each { |word| @pretexts << word.delete("\n") }
  end

  def top_words_counter
    while @words.any?
      check = @words.first
      @top_words[check] = 0
      @words.each { |word| @top_words[check] += 1 if word == check && !@pretexts.include?(word) }
      @words.delete(check)
    end
  end

  def res(value)
    @top_words = (@top_words.sort_by { |_key, val| val }).reverse
    0.upto(value - 1) do |index|
      word = @top_words[index]
      puts word[0] + ' - ' + word[1].to_s + ' раз(а)'
    end
  end

  def ready_top_words
    check_all_words
    pretexts_value
    top_words_counter
  end
end

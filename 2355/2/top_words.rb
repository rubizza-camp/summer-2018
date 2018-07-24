require './rapper.rb'
require './battle.rb'

# This class is needed to find most popular words from text files
class TopWord
  attr_reader :battler

  def initialize(name)
    @battler = Rapper.new(name)
    @pretexts = []
    @words = []
    @hash = @battler.favourite_words
  end

  def clear_words(line)
    line.split.each do |word|
      word = word.delete '.', ',', '?»', '&quot', '!', ';'
      @words << word
    end
  end

  def check_words_in_text(number)
    Battle.new(@battler.name, number).file.each do |line|
      clear_words(line)
    end
  end

  def check_all_words
    1.upto(@battler.battle_count) do |number|
      check_words_in_text(number)
    end
  end

  def pretexts_value
    File.new('./pretexts').each { |word| @pretexts << word.delete("\n") }
  end

  def top_words_counter
    while @words.any?
      check = @words.first
      @hash[check] = 0
      @words.each { |word| @hash[check] += 1 if word == check && !@pretexts.include?(word) }
      @words.delete(check)
    end
  end

  def ready_top_words
    check_all_words
    pretexts_value
    top_words_counter
  end

  def res(value)
    most_words = (@hash.sort_by { |_key, val| val }).reverse
    0.upto(value - 1) do |index|
      word = most_words[index]
      puts word[0] + ' - ' + word[1].to_s + ' раз(а)'
    end
  end
end

# Class represents Helper to count words/bad words/words per round
class WordCounterHelper
  def initialize(bw_array)
    @words_count = 0
    @words_per_round = 0
    @array_round = []
    @bad_words_count = 0
    @bad_words_array = bw_array
  end

  attr_reader :words_count, :words_per_round, :array_round, :bad_words_count, :bad_words_array

  def save_word_count_round
    @array_round << @words_per_round
  end

  def add_word_count
    @words_count += 1
  end

  def add_word_count_round
    @words_per_round += 1
  end

  def add_bad_word_count
    @bad_words_count += 1
  end

  def drop_words_round_count
    @words_per_round = 0
  end
end

def word_counter(file_path)
  helper = WordCounterHelper.new YAML.safe_load(File.open('config.yml').read)['bad_words']

  File.open(file_path).each_line do |line|
    next if round? helper, line

    words_count helper, line.split
  end
  helper.save_word_count_round
  prepare_hash helper
end

def words_count(helper, words)
  words.each do |word|
    word = word.gsub(/,.!?'":/, '')
    helper.add_word_count
    helper.add_word_count_round

    helper.bad_words_array.each do |bw|
      helper.add_bad_word_count if word.downcase.include? bw.downcase
    end
  end
end

def round?(helper, line)
  if line.include? 'Раунд'.downcase
    helper.save_word_count_round
    helper.drop_words_round_count
    return true
  end
  false
end

def prepare_hash(helper)
  hash = { total: helper.words_count }
  hash.merge!(bad: helper.bad_words_count, round: (helper.array_round.sum / helper.array_round.length))
end

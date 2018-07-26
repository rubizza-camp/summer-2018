require_relative 'rappers_parser'

# Class represents Controller for Rappers which most use bad words
class TopBadWordsController
  include RappersParser

  def initialize(destination, count)
    @rappers = get_rappers_list destination
    @count = count
    @helper = WordCounterHelper.new YAML.safe_load(File.open('config.yml').read)['bad_words']
    @destination = destination
  end

  def top_bad_word_rappers
    @rappers.each do |_key, value|
      value.words_info_during_battles.battles_history.each do |file|
        hash = word_counter(@destination + '/' + file)
        value.words_info_during_battles.set_result hash[:total], hash[:bad], hash[:round]
      end
    end
    print_out @rappers, @count
  end

  def print_out(rappers, top)
    Hash[rappers.sort_by { |_k, value| [-value.words_info_during_battles.bad_words] }[0..top]].each do |_key, val|
      TopBadWordView.write_to_console val, val.words_info_during_battles.bad_words.fdiv(val.battles_counter).round(2)
    end
  end

  def word_counter(file_path)
    File.open(file_path).each_line do |line|
      next if round line
      words_count line.split
    end
    @helper.save_word_count_round
    prepare_hash
  end

  def words_count(line)
    line.each do |word|
      word = word.gsub(/,.!?'":/, '')
      @helper.add_word_count
      @helper.add_word_count_round

      @helper.bad_words_array.each do |bw|
        @helper.add_bad_word_count if word.downcase.include? bw.downcase
      end
    end
  end

  def round(line)
    if line.include? 'Раунд'.downcase
      @helper.save_word_count_round
      @helper.drop_words_round_count
      return true
    end
    false
  end

  def prepare_hash
    hash = { total: @helper.words_count }
    hash.merge!(bad: @helper.bad_words_count, round: (@helper.array_round.sum / @helper.array_round.length))
  end
end

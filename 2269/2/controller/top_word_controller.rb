require_relative 'rappers_parser'

# This class represents Controller, which counts most popular Words of selected Rapper.
class TopWordController
  include RappersParser

  def initialize(destination, rapper_name, count)
    @destination = destination
    @rapper_name = rapper_name
    @count = count
    @rappers = get_rappers_list destination
    @helper = TopWordHelper.new 'config.yml', 'excluded_words'
  end

  def check_rapper_name
    if @rappers.key? @rapper_name
      top_word_count
    else
      TopWordView.write_to_console_rappers @rappers, @rapper_name
      exit(true)
    end
  end

  def top_word_count
    @rappers[@rapper_name].words_info_during_battles.battles_history.each do |file|
      parse_helper File.open(@destination + '/' + file)
    end
    print_top_words
  end

  def print_top_words
    Hash[@helper.word_count.sort_by { |_k, val| -val }[0..@count]].each do |key, value|
      TopWordView.write_to_console(key, value)
    end
  end

  def parse_helper(text_file)
    text_file.each_line do |line|
      line.chomp.split(/[,\s.?!"«»:—;[&quot]-]+/).each do |word|
        next if word.empty? || word.length < 3
        is_word = true

        @helper.no_word_array.each { |value| is_word = false if word.downcase.eql? value }
        @helper.increase_word_counter word if is_word
      end
    end
  end
end

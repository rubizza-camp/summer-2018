# Class which helps to count words only (unions etc. are excluded)
class TopWordHelper
  def initialize
    @no_word_array = read_from_file
    @word_count = Hash.new(0)
  end

  def read_from_file
    YAML.safe_load(File.open('config.yml').read)['excluded_words']
  end

  attr_reader :no_word_array, :word_count

  def increase_word_counter(key)
    @word_count[key] += 1
  end
end

def top_word_count(destination, raper_name, count)
  check_raper_name get_rapers_list(destination), raper_name

  helper = TopWordHelper.new

  get_rapers_list(destination)[raper_name].words_info_during_battles.file_name.each do |file|
    parse_helper File.open(destination + '/' + file), helper
  end
  print_top_words(helper, count)
end

def print_top_words(helper, count)
  delimiter = 1
  helper.word_count.sort_by { |_k, val| -val }.each do |key, value|
    break if delimiter > count
    puts key.capitalize + ' - ' + value.to_s
    delimiter += 1
  end
end

def check_raper_name(rapers, raper_name)
  return if rapers.key? raper_name
  puts "\nРэпер #{raper_name} не судился. Осуждены следующие:\n\n"
  rapers.each { |_key, value| puts value.name }
  exit(true)
end

def parse_helper(text_file, helper)
  text_file.each_line do |line|
    words = line.chomp.split(/[,\s.?!"«»:—;[&quot]-]+/)

    words.each do |word|
      next if word.empty? || word.length < 3
      is_word = true

      helper.no_word_array.each { |value| is_word = false if word.downcase.eql? value }
      helper.increase_word_counter word if is_word
    end
  end
end

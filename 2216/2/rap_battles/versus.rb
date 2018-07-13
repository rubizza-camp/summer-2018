#!/usr/bin/ruby
require 'optparse'
require 'russian_obscenity'

# methods for first level
# -------------------------------------------------------------------------------------------------------
# This method smells of :reek:UtilityFunction
def count_bad_words(all_words)
  bad_words = all_words.select do |word|
    word.include?('*') || word.include?('(..') || RussianObscenity.obscene?(word)
  end
  bad_words.size
end

# This method smells of :reek:UtilityFunction
def get_words(name_of_file)
  fname = File.open(name_of_file, 'r')
  content = fname.read
  fname.close
  content.downcase.split(' ')
end

# This method smells of :reek:UtilityFunction
def identify_round(words, raund, line_of_battle)
  if line_of_battle.match(/Раунд [1|2|3][^\s]*/) && raund != ''
    words << raund
  else
    raund << line_of_battle + ' '
  end
end

# This method smells of :reek:TooManyStatements
# This method smells of :reek:FeatureEnvy
# This method smells of :reek:UtilityFunction
def get_avarage(name_of_file)
  raunds_words = []
  raund_text = ''
  fname = File.open(name_of_file, 'r')
  fname.each_line { |line| identify_round(raunds_words, raund_text, line) }
  raunds_words << raund_text
  raunds_words.map! { |raund| raund.split(' ').size }.inject(0) { |result, elem| result + elem } / raunds_words.size
end

# This method smells of :reek:UtilityFunction
def check_if_read_battle(file_name, name)
  file_name.include?(name) && (file_name.index(name) == file_name.index('/') + 2 ||
  file_name.index(name) == file_name.index('/') + 1)
end

# This method smells of :reek:TooManyStatements
def count_criterias(files_names, name, avge)
  bad_words_num = 0
  battles_num = 0
  files_names.each do |file_name|
    next unless check_if_read_battle(file_name, name)
    words = get_words(file_name)
    battles_num += 1
    bad_words_num += count_bad_words(words)
    avge += get_avarage(file_name)
  end
  [battles_num, bad_words_num, bad_words_num / battles_num, avge.div(battles_num)]
end

# This method smells of :reek:FeatureEnvy
def get_inf_about(partic_name, names_of_files, participants_bad_words)
  avge = 0
  participants_bad_words[partic_name] = count_criterias(names_of_files, partic_name, avge)
end

# This method smells of :reek:UtilityFunction
def get_rest_properties(properties, participant_inf)
  1.upto(4) do |index|
    participant_inf[1][index - 1] = participant_inf[1][index - 1].to_s
    properties[index] << participant_inf[1][index - 1]
  end
end

# This method smells of :reek:TooManyStatements
# This method smells of :reek:FeatureEnvy
# This method smells of :reek:UtilityFunction
def get_properties_for_grid(partic_in_top, prop_array)
  prop = Array.new(5) { [] }
  partic_in_top.map do |value|
    prop[0] << value[0]
    get_rest_properties(prop, value)
  end
  0.upto(4) do |index|
    prop_array[index] = prop[index].max_by(&:size).size + 1
  end
end

# This method smells of :reek:UtilityFunction
def get_rest_row(row, partic_in_top, prop)
  0.upto(3) do |index|
    cell = partic_in_top[1][index]
    cell += ' ' while cell.size != prop[index + 1]
    row += cell + '|'
  end
  row
end

# This method smells of :reek:FeatureEnvy
def print_row(partic_in_top, properties)
  row = ''
  cell = partic_in_top[0]
  cell += ' ' while cell.size != properties[0]
  row += cell + '|' + get_rest_row(row, partic_in_top, properties)
  puts row
end

# This method smells of :reek:TooManyStatements
def output_top(bad_words, top_number)
  top_partic = []
  properties = Array.new(5) { 0 }
  bad_words = bad_words.sort_by { |_key, value| value[2] }.reverse
  top_number.times { top_partic << bad_words.shift }
  get_properties_for_grid(top_partic, properties)
  top_partic.each { |participant| print_row(participant, properties) }
end
# ----------------------------------------------------------------------------------------------------

# methods for second level
# ----------------------------------------------------------------------------------------------------

# This method smells of :reek:FeatureEnvy
def get_all_words(name, names_of_files)
  words = []
  names_of_files.each do |file_name|
    words += get_words(file_name) if file_name.include?(name) && (file_name.index(name) == file_name.index('/') + 2 ||
                                  file_name.index(name) == file_name.index('/') + 1)
  end
  words
end

# This method smells of :reek:UtilityFunction
def rm_excess_words(words)
  words.each { |word| words.delete(word) if word.size < 5 }
  words = words.reject(&:nil?)
end

# This method smells of :reek:FeatureEnvy
def output_words(counts_of_words, num_for_output)
  num_for_output.times do
    word_with_count = counts_of_words.shift
    if word_with_count[1].between?(2,4)
      puts word_with_count[0] + ' - ' + word_with_count[1].to_s + ' раза'
    else
      puts word_with_count[0] + ' - ' + word_with_count[1].to_s + ' раз'
    end
  end
end

# This method smells of :reek:TooManyStatements
def search_top_words_for_participant(name, names_of_files, num_for_output)
  counts = {}
  # remove excess symbols
  words = get_all_words(name, names_of_files).map! { |word| word.gsub(/[,:;.?!«»]|&quot/, '') }
  words = rm_excess_words(words).each { |word| counts[word] = words.count(word) unless counts.include?(word) }
  counts = counts.sort_by { |_key, value| value }.reverse
  output_words(counts, num_for_output)
end

# -----------------------------------------------------------------------------------------------------

# get env variables
# --------------------------------------------------------------------------------------------
options = { top_bad_words: nil, name: nil, top_words: nil }

parser = OptionParser.new do |opts|
  opts.banner = 'Usage: versus.rb [options]'
  opts.on('--top-bad-words number') do |number|
    options[:top_bad_words] = number
  end

  opts.on('--name name') do |name|
    options[:name] = name
  end

  opts.on('--top-words number') do |number|
    options[:top_words] = number
  end
end

parser.parse!
# ---------------------------------------------------------------------------------------------

if options.values.all?(&:nil?)
  puts 'Wrong number of parameters'
else
  participants_bad_words = {}
  names_of_files = Dir['rap-battles/*']
  participants_names = []
  input_vars = options.reject { |_key, value| value.nil? }

  file_with_names = File.open('participants', 'r')
  file_with_names.each_line { |line| participants_names << line.chop! }
  file_with_names.close

  # first level
  # --------------------------------------------------------------------------------------------
  if input_vars.include?(:top_bad_words)
    until options[:top_bad_words] =~ /\A[-+]?[0-9]*\.?[0-9]+\Z/
      print 'Enter integer Number: '
      options[:top_bad_words] = gets.chomp
    end
    participants_names.each { |name| get_inf_about(name, names_of_files, participants_bad_words) }
    output_top(participants_bad_words, Integer(options[:top_bad_words]))
  end
  # -------------------------------------------------------------------------------------------

  # second level
  # --------------------------------------------------------------------------------------------
  if input_vars.include?(:name)
    options[:top_words] = 30 if options[:top_words].nil? || options[:top_bad_words] == ''
    options[:name] = options[:name].tr('_', ' ')
    if participants_names.include?(options[:name])
      search_top_words_for_participant(options[:name], names_of_files, Integer(options[:top_words]))
    else
      puts 'Неизвестное имя ' + options[:name] + '. Вы можете ввести одно из следующих имён: '
      participants_names.each { |name| puts name }
    end
  end
  # -------------------------------------------------------------------------------------------
end

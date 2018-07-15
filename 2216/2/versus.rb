require 'optparse'
require 'russian_obscenity'
require 'unicode'
require_relative 'badwordsanalizator'
require_relative 'topwordsanalizator'

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

# This method smells of :reek:TooManyStatements
# This method smells of :reek:UtilityFunction
def get_rest_row(row, partic_in_top, prop)
  names_of_columns = [' баттлов', ' нецензурных слов', ' слов на баттл', ' слов в раунде']
  0.upto(3) do |index|
    cell = partic_in_top[1][index] + names_of_columns[index]
    cell += ' ' while cell.size != prop[index + 1] + names_of_columns[index].size
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
    participants_names.each do |name|
      analizator = BadWordsAnalizator.new
      analizator.collect_inf_about(name, names_of_files, participants_bad_words)
    end
    output_top(participants_bad_words, Integer(options[:top_bad_words]))
  end
  # -------------------------------------------------------------------------------------------

  # second level
  # --------------------------------------------------------------------------------------------
  if input_vars.include?(:name)
    options[:top_words] = 30 if options[:top_words].nil? || options[:top_bad_words] == ''
    options[:name] = options[:name].tr('_', ' ')
    if participants_names.include?(options[:name])
      analizator = TopWordsAnalizator.new
      analizator.search_top_words_for_participant(options[:name], names_of_files, Integer(options[:top_words]))
    else
      puts 'Неизвестное имя ' + options[:name] + '. Вы можете ввести одно из следующих имён: '
      participants_names.each { |name| puts name }
    end
  end
  # -------------------------------------------------------------------------------------------
end

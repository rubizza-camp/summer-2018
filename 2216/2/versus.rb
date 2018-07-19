#!/usr/bin/ruby
require 'optparse'
require 'russian_obscenity'
require 'unicode'
require_relative 'badwordsanalizator'
require_relative 'topwordsanalizator'
require_relative 'battle'

class TablePrinter
  def output_top(bad_words, top_number)
    top_participant = []
    properties = Array.new(5) { 0 }
    get_top_participants(bad_words, top_participant, top_number)
    print_top_participant(top_participant, properties)
  end

  private

  def get_top_participants(bad_words, top_participant, top_number)
    bad_words = bad_words.sort_by { |_key, value| value[1] }.reverse
    top_number.times { top_participant << bad_words.shift }
  end

  def print_top_participant(top_participant, properties)
    get_the_properties_for_grid(top_participant, properties)
    top_participant.each { |participant| print_the_row(participant, properties) }
  end

  def get_the_properties_for_grid(participant_in_top, properties_for_cell)
    cell_arrays = Array.new(5) { [] }
    participant_in_top.each { |participant_inf| get_name_field(cell_arrays, participant_inf) }
    get_prop_array(properties_for_cell, cell_arrays)
  end

  def get_name_field(cell_arrays, participant_inf)
    cell_arrays[0] << participant_inf[0]
    get_the_rest_properties(cell_arrays, participant_inf)
  end

  def get_the_rest_properties(cells, participant_inf)
    1.upto(4) do |index|
      participant_inf[1][index - 1] = participant_inf[1][index - 1].to_s
      cells[index] << participant_inf[1][index - 1]
    end
  end

  def get_prop_array(cell_properties_array, cells)
    0.upto(4) do |index|
      cell_properties_array[index] = cells[index].max_by(&:size).size + 1
    end
  end

  def print_the_row(participant_in_top, properties)
    row = ''
    row += make_cell(participant_in_top[0], '', properties[0]) + '|' +
           get_the_rest_inf_for_row(row, participant_in_top, properties)
    puts row
  end

  def make_cell(criterion, column_name, prop_cell_size)
    cell = criterion + column_name
    cell += ' ' while cell.size != prop_cell_size + column_name.size
    cell
  end

  def get_the_rest_inf_for_row(row, participant_in_top, props)
    column_names = [' баттлов', ' нецензурных слов', ' слов на баттл', ' слов в раунде']
    0.upto(3) do |index|
      row += make_cell(participant_in_top[1][index], column_names[index], props[index + 1]) + '|'
    end
    row
  end
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
  participant_bad_words = {}
  participant_names = []
  input_vars = options.reject { |_key, value| value.nil? }

  file_with_names = File.open('participants', 'r')
  file_with_names.each_line { |line| participant_names << line.chop! }
  file_with_names.close

  # first level
  # --------------------------------------------------------------------------------------------
  if input_vars.include?(:top_bad_words)
    until options[:top_bad_words] =~ /\A[-+]?[0-9]*\.?[0-9]+\Z/ &&
          Integer(options[:top_bad_words]) <= participant_names.size
      print 'Enter correct integer Number: '
      options[:top_bad_words] = gets.chomp
    end

    participant_names.each do |name|
      battle = Battle.new(name)
      analyzer = BadWordsAnalyzer.new(battle.titles)
      participant_bad_words[name] = analyzer.analyze_bad
    end

    printer = TablePrinter.new
    printer.output_top(participant_bad_words, Integer(options[:top_bad_words]))
  end
  # -------------------------------------------------------------------------------------------

  # second level
  # --------------------------------------------------------------------------------------------
  if input_vars.include?(:name)
    options[:top_words] = 30 if options[:top_words].nil? || options[:top_bad_words] == ''
    options[:name] = options[:name].tr('_', ' ')

    if participant_names.include?(options[:name])
      battle = Battle.new(options[:name])
      analyzer = TopWordsAnalyzer.new(battle.titles, Integer(options[:top_words]))
      analyzer.analyze_top
    else
      puts 'Неизвестное имя ' + options[:name] + '. Вы можете ввести одно из следующих имён: '
      participant_names.each { |name| puts name }
    end
  end
  # -------------------------------------------------------------------------------------------
end

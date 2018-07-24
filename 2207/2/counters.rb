require 'russian_obscenity'
require_relative 'service'
# The module Counters is responsible for counting words in text which done to him

module Counters
  # This method smells of :reek:UtilityFunction
  def read_files_with_buttles(battle)
    Dir.chdir(Service.path) { File.read(battle) }
  end

  # This method smells of :reek:TooManyStatements
  def count_normal(battles)
    unnessasry_symbols = /[.!-?,:]/
    words = 0
    lines = []
    battles.each_with_object([]) do |bat, _|
      words += read_files_with_buttles(bat).gsub(unnessasry_symbols, ' ').strip.split.count
    end
    battles.each do |battle|
      lines = Dir.chdir(Service.path) { File.readlines(battle) }
    end
    count_words_per_rounds(words, lines)
  end

  # This method smells of :reek:UtilityFunction
  def count_words_per_rounds(words, lines)
    revelant_lines = lines.find_all { |line| line.include?('Раунд') }.count
    revelant_lines = 1 if revelant_lines.zero?
    words / revelant_lines
  end

  def count_bad(battles)
    bad_words = 0
    battles.each do |battle|
      bad_words += count_bad_words(read_files_with_buttles(battle))
    end
    bad_words
  end

  # This method smells of :reek:UtilityFunction
  # I think it will be better to paste this code here in couse of small project
  def count_bad_words(file)
    file.split.each_with_object([]) { |word, arr| arr << word if RussianObscenity.obscene?(word) }.count
  end
end

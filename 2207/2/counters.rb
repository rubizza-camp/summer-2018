require 'russian_obscenity'
require_relative 'service'
# The module Counters is responsible for counting words in text which done to him

module Counters
  
  UNNESSESARY_SYMBOLS = /[.!-?,:]/
  # This method smells of :reek:UtilityFunction
  def read_files_with_buttles(battle)
    Dir.chdir(Service::PATH) { File.read(battle) }
  end

  def count_normal(battles)
    count_hash = battles.each_with_object({ words: [], lines: [] }) do |bat, hsh|
      hsh[:words] << read_files_with_buttles(bat).gsub(UNNESSESARY_SYMBOLS, ' ').strip.split
      hsh[:lines] << Dir.chdir(Service::PATH) { File.readlines(bat) }
    end
    count_words_per_rounds(count_hash)
  end

  # This method smells of :reek:UtilityFunction
  def count_words_per_rounds(hash)
    revelant_lines = hash[:lines].flatten.find_all { |line| line.include?('Раунд') }.count
    revelant_lines = 1 if revelant_lines.zero?
    hash[:words].flatten.select! { |word| word.size > 3 }.count / revelant_lines
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

require 'russian_obscenity'
require_relative 'service'
# The module Counters is responsible for counting words in text which done to him
module Counters
  # This method smells of :reek:UtilityFunction
  # I think it will be better to paste this code here in couse of small project
  def read_files_with_buttles(battle)
      Dir.chdir(Service.path) { File.read(battle) }
  end

  def count_normal(battles)
    unnessasry_symbols = /[.!-?,:]/
    words = 0
    lines = []
    lines_with_value = []
    battles.each_with_object([]) { |bat, arr| words += read_files_with_buttles(bat)
                  .gsub(unnessasry_symbols, ' ').strip.split.count }
#    words += read_files_with_buttles(battle).split.each_with_object([]) { |word, arr| arr << word if word.gsub(unnessasry_symbols, ' ').strip.split(//).count > 3 }
    
    battles.each do |battle|
    lines = Dir.chdir(Service.path) { File.readlines(battle) }
    end
    revelant_lines = lines.find_all {|line| line.include?("Раунд") }
    revelant_lines = [1] if revelant_lines.count == 0
    words / revelant_lines.count
    end


  def count_bad(battles)
    bad_words = 0
    battles.each do |battle|
      bad_words += count_bad_words(read_files_with_buttles battle)
    end
    bad_words
  end
  # This method smells of :reek:UtilityFunction
  # I think it will be better to paste this code here in couse of small project

  def count_bad_words(file) 
  file.split.each_with_object([]) { |word, arr| arr << word if RussianObscenity.obscene?(word) }.count
  end

end

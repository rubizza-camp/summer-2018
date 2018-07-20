require_relative 'battles_class'
require_relative 'word_analizer_class'
require 'russian_obscenity'
# This class keeps the information about rapper
# :reek:Attribute
# :reek:TooManyInstanceVariables
class Rapper
  attr_accessor :battles
  attr_reader :words_per_battle, :bad_words, :name
  def initialize(filename)
    @name = filename[/((\w|\d|.|\s)*?)(?=против|[vV][Ss] )/]
    @bad_words = 0
    @battles = 1
  end

  # inject made everything so much easier
  # :reek:UncommunicativeVariableName
  # :reek:TooManyStatements
  def count_bad_words(battle)
    exp = /\W*\*\W*/
    file = File.readlines(battle.filename).inject { |str, line| str << line }
    word_arr = file.split
    @bad_words += word_arr.count { |w| RussianObscenity.obscene?(w) || w[exp] }
  end

  # :reek:UtilityFunction
  def read_file(filename, file_array)
    File.foreach filename do |line|
      file_array.push(line)
    end
  end

  def count_words_per_battle
    @words_per_battle = @bad_words / @battles
  end
end

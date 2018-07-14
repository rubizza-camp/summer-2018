# Class that represents each Rap Singer
# :reek:Attribute
# :reek:TooManyInstanceVariables
class Raper
  def initialize(a_name)
    @name = a_name
    @words_round = 0
    @words_battle = 0
    @bad_words = 0
    @battles = 0
    @file_name = []
  end

  attr_reader :words_battle, :bad_words, :battles, :name, :file_name
  attr_accessor :words_round

  def add_battle
    @battles += 1
  end

  def add_file_name(file)
    @file_name << file
  end

  def add_words_count(count)
    @words_battle += count
  end

  def add_bad_words(count)
    @bad_words += count
  end
end

# Class that represents each Rap Singer.
# :reek:Attribute
# :reek:TooManyInstanceVariables
class Raper
  def initialize(a_name)
    @name ||= a_name
    @words_round ||= 0
    @words_battle ||= 0
    @bad_words ||= 0
    @battles ||= 0
    @file_name ||= []
  end

  attr_reader :words_battle, :bad_words, :battles, :name, :file_name
  attr_reader :words_round

  def add_battle(file)
    @battles += 1
    @file_name << file
  end

  def set_result(total, bad, round)
    @words_battle += total
    @bad_words += bad
    @words_round = round
  end
end

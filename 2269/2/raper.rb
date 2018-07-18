# Class represents Info about Raper
class BattleInfo
  def initialize
    @words_round ||= 0
    @words_battle ||= 0
    @bad_words ||= 0
  end

  attr_reader :words_battle, :bad_words, :words_round

  def set_result(total, bad, round)
    @words_battle += total
    @bad_words += bad
    @words_round = round
  end
end

# Class that represents each Rap Singer.
class Raper < BattleInfo
  def initialize
    @battles ||= 0
    @file_name ||= []
    super
  end

  attr_reader :battles, :name, :file_name, :info

  def add_battle(file, name)
    @battles += 1
    @file_name << file
    @name = name
  end
end

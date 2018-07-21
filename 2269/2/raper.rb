# Class represents Info about Raper
class BattleInfo
  def initialize
    @words_round ||= 0
    @words_battle ||= 0
    @bad_words ||= 0
    @file_name ||= []
  end

  attr_reader :words_battle, :bad_words, :words_round, :file_name

  def set_result(total, bad, round)
    @words_battle += total
    @bad_words += bad
    @words_round = round
  end

  def file_source_info(file)
    @file_name << file
  end
end

# Class that represents each Rap Singer.
class Raper
  def initialize(name)
    @battles ||= 0
    @name = name
    @words_info_during_battles = BattleInfo.new
  end

  attr_reader :battles, :name, :words_info_during_battles

  def add_battle
    @battles += 1
  end
end

# Class represents Info about Raper during Battles
class BattlesInfo
  def initialize
    @words_round = 0
    @words_battle = 0
    @bad_words = 0
    @battles_history = []
  end

  attr_reader :words_battle, :bad_words, :words_round, :battles_history

  def set_result(total, bad, round)
    @words_battle += total
    @bad_words += bad
    @words_round = round
  end

  def file_source_info(file)
    @battles_history << file
  end
end
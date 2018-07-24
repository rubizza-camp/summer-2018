# Class that represents each Rap Singer.
class Rapper
  def initialize(name)
    @battles_counter = 0
    @name = name
    @words_info_during_battles = BattlesInfo.new
  end

  attr_reader :battles_counter, :name, :words_info_during_battles

  def add_battle
    @battles_counter += 1
  end
end

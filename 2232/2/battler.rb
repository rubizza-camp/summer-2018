class Battler
  attr_reader :name_bat, :params
  def initialize(name_bat, count_bat, count_curse, curse_battle, word_round)
    @name_bat = name_bat
    @params = [count_bat, count_curse, curse_battle, word_round]
  end

  def show
    [@name_bat, @params[0], @params[1], @params[2], @params[3]]
  end
end

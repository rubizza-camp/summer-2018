class Artist
  attr_reader :name, :battle_list

  def initialize(name)
    @name = name
    @battle_list = []
  end

  def add_battle(battle)
    @battle_list << battle
  end

  def bad_words_capacity
    @battle_list.inject(0) { |result, battle| result + Parser.bad_words_in_battle(battle) }
  end

  def words_in_battle_average
    @battle_list.sum(&:count) / battle_capacity
  end

  def words_in_round_average
    words_in_battle_average / 3
  end

  def battle_capacity
    @battle_list.size
  end
end

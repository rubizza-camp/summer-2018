class Battler
  attr_reader :name, :words_data
  def initialize(name, battles_count, bad_words_count, bad_in_round, words_in_round)
    @name = name
    @words_data = [battles_count, bad_words_count, bad_in_round, words_in_round]
  end
end

class Battler
  attr_reader :name, :parametres
  def initialize(name, battles_count, bad_words_count, bad_in_round, words_in_round)
    @name = name
    @parametres = [battles_count, bad_words_count, bad_in_round, words_in_round]
  end
end

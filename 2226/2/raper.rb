# This class is used for single raper methods
class Raper
  attr_reader :raper_name

  def initialize(raper_name)
    @raper_name = raper_name
  end

  def number_of_battles
    Battle.new(@raper_name).number_of_battles
  end

  def number_of_swear_words
    Battle.new(@raper_name).number_of_swear_words
  end

  def number_of_words_in_rounds
    Battle.new(@raper_name).number_of_words_in_rounds
  end

  def number_of_rounds
    Battle.new(@raper_name).number_of_rounds
  end

  def average_number_swearing_words_in_battle
    Battle.new(@raper_name).average_number_swearing_words_in_battle
  end

  def average_number_words_in_round
    Battle.new(@raper_name).average_number_words_in_round
  end

  def the_most_used_words(top_words)
    array_storage = Battle.new(@raper_name).storage_for_all_text.gsub(/,|'/, ' ').split
    array_storage = Battle.new(@raper_name).delete_prons(array_storage)
    Battle.new(@raper_name).count_dupls(array_storage).sort_by { |_, value| value }.reverse.to_h.first(top_words.to_i)
  end
end

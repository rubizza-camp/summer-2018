# This class is used for single rapper methods
class Rapper
  include Helper

  attr_reader :rapper_name

  def initialize(rapper_name)
    @rapper_name = rapper_name
  end

  def number_of_battles
    RapperDataStore.new(@rapper_name).data_for_one_rapper.keys.size
  end

  def number_of_swear_words
    RapperDataStore.new(@rapper_name).data_for_one_rapper.sum do |_, battle_content|
      Battle.new(battle_content).number_of_swear_words
    end
  end

  def average_number_swearing_words_in_battles
    number_of_swear_words.fdiv(number_of_battles)
  end

  def average_number_words_in_round
    RapperDataStore.new(@rapper_name).data_for_one_rapper.sum do |_, battle_content|
      Battle.new(battle_content).average_number_words_in_round
    end
  end

  def the_most_used_words(top_words)
    array_storage = RapperDataStore.new(@rapper_name).data_for_one_rapper.values.join(' ').gsub(/,|'/, ' ').split
    array_storage = Helper.delete_pronouns(array_storage)
    Helper.duplicates_counter(array_storage).sort_by { |_, value| value }.reverse.to_h.first(top_words.to_i)
  end
end

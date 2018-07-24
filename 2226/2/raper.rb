# This class is used for single raper methods
class Raper
  include Helper

  attr_reader :raper_name

  def initialize(raper_name)
    @raper_name = raper_name
    @all_data_hash = DataStorage.new.show_all_data
  end

  def data_for_one_raper
    @data_for_one_raper ||= filter_one_raper_data
  end

  def filter_one_raper_data
    @all_data_hash.each_with_object({}) do |(file_name, file_content), hash|
      hash[file_name.to_s] = file_content.to_s if file_name =~ /#{@raper_name}_против/
    end
  end

  def number_of_battles
    data_for_one_raper.keys.size
  end

  def number_of_swear_words
    data_for_one_raper.sum do |battle_name, battle_content|
      Battle.new(battle_name, battle_content).number_of_swear_words
    end
  end

  def average_number_swearing_words_in_battles
    number_of_swear_words.fdiv(number_of_battles)
  end

  def average_number_words_in_round
    data_for_one_raper.sum do |battle_name, battle_content|
      Battle.new(battle_name, battle_content).average_number_words_in_round
    end
  end

  def the_most_used_words(top_words)
    array_storage = data_for_one_raper.values.join(' ').gsub(/,|'/, ' ').split
    array_storage = delete_prons(array_storage)
    count_dupls(array_storage).sort_by { |_, value| value }.reverse.to_h.first(top_words.to_i)
  end

  private

  def count_dupls(array_storage)
    duplicates_counter(array_storage)
  end

  def delete_prons(array_storage)
    delete_pronouns(array_storage)
  end
end

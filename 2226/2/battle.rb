# Class to battles of raper
class Battle
  include Helper

  SWEAR_WORDS = YAML.load_file('config.yml')['SWEAR_WORDS_ARRAY'].join('|')

  def initialize(raper_name)
    @raper_name = raper_name
    @all_data_hash = DataStorage.show_all_data
    @data_for_one_raper = filter_one_raper_data
  end

  def storage_for_all_text
    @data_for_one_raper.values.join(' ')
  end

  def filter_one_raper_data
    @all_data_hash.each_with_object({}) do |(file_name, file_content), hash|
      hash[file_name.to_s] = file_content.to_s if file_name =~ /#{@raper_name}_против/
    end
  end

  def number_of_battles
    @data_for_one_raper.sum do |file_name, _|
      file_name.scan(/#{@raper_name}_против/).size
    end
  end

  def number_of_swear_words
    @data_for_one_raper.sum do |_, file_content|
      file_content.scan(/#{SWEAR_WORDS}/).size
    end
  end

  def number_of_words_in_rounds
    @data_for_one_raper.sum do |_, file_content|
      file_content.split(/ [а-яА-ЯёЁ*]+/).size
    end
  end

  def number_of_rounds
    @data_for_one_raper.sum(1) do |_, file_content|
      file_content.scan(/Раунд \w/).size
    end
  end

  def average_number_swearing_words_in_battle
    number_of_swear_words.fdiv(number_of_battles)
  end

  def average_number_words_in_round
    number_of_words_in_rounds / number_of_rounds
  end

  def count_dupls(array_storage)
    duplicates_counter(array_storage)
  end

  def delete_prons(array_storage)
    delete_pronouns(array_storage)
  end
end

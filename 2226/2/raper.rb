# This class is used for single raper methods
class Raper
  attr_reader :raper_name

  SWEAR_WORDS = YAML.load_file('config.yml')['SWEAR_WORDS_ARRAY'].join('|')

  def initialize(raper_name)
    @raper_name = raper_name
  end

  def avg_number_of_battles
    DataStorage.show_all_data.sum do |file_name, _|
      file_name.scan(@raper_name).size
    end
  end

  def number_of_battles
    avg_number_of_battles / 2
  end

  def number_of_swear_words
    DataStorage.show_all_data.inject(0) do |counter, (file_name, file_content)|
      counter += file_content.scan(/#{SWEAR_WORDS}/).size if file_name.match(@raper_name)
      counter
    end
  end

  def average_number_swearing_words_in_battle
    number_of_swear_words.fdiv(number_of_battles)
  end

  def number_of_words_in_rounds
    DataStorage.show_all_data.inject(0) do |counter, (file_name, file_content)|
      counter += file_content.split(/ [а-яА-ЯёЁ*]+/).size if file_name.match(@raper_name)
      counter
    end
  end

  def number_of_rounds
    real_raper_name = @raper_name
    DataStorage.show_all_data.inject(1) do |counter, (file_name, file_content)|
      counter += file_content.scan(/Раунд \w/).size if file_name.match(real_raper_name)
      counter
    end
  end

  def average_number_words_in_round
    number_of_words_in_rounds / number_of_rounds
  end
end

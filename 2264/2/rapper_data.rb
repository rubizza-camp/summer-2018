require './storage'
require './rappers_list'
# class for rapper's data processing
class RapperData
  attr_reader :rapper_name

  def initialize(rapper_name)
    @rapper_name = rapper_name
  end

  def count_all_battles
    Storage.all_data.inject(0) do |counter, (file_name, _file_content)|
      counter + file_name.scan(@rapper_name).size
    end
  end

  def count_avg_battles
    count_all_battles / 2
  end

  def count_bad_words
    Storage.all_data.inject(0) do |counter, (file_name, file_content)|
      counter += file_content.scan(/уй|сос|залуп|[*]/).size if file_name.match(@rapper_name)
      counter
    end
  end

  def count_avg_bad_words_in_battle
    average = count_bad_words / count_avg_battles.to_f
    average.round(2)
  end

  def count_avg_words_in_round
    Storage.all_data.inject(0) do |counter, (file_name, file_content)|
      counter += file_content.split(/\w/).size if file_name.match(@rapper_name)
      counter
    end
  end
end

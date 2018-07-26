# Data Analysis
class MostObsceneRappersFinder
  def initialize
    @data_read = DataStorage.new
  end

  def most_obscene_rappers
    @data_read
      .find_names_of_the_rappers
      .each_with_object([]) { |name, row| row << RapperAnalyzer.new(name, @data_read.find_all_battles(name)) }
  end
end

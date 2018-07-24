# Data Analysis
class MostObsceneRappersFinder
  def initialize(number)
    @data = DataStorage.new
    @number = number
  end

  def stats_of_rappers
    @data
      .find_names_of_the_rappers
      .each_with_object([]) { |name, row| row << RapperAnalyzer.new(name, @data.find_all_battles(name)).fetch_stats }
      .sort_by { |stats| stats[2] }.reverse.first(@number.to_i)
  end
end

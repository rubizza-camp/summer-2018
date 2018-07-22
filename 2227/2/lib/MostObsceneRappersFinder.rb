# Data Analysis
class MostObsceneRappersFinder
  def self.stats_of_rappers(number)
    data = DataStorage.new
    data
      .find_names_of_the_rappers
      .each_with_object({}) { |name, hash| hash[name] = RapperAnalyzer.new(name, data).fetch_statistic }
      .sort_by { |_name, stats| stats[:bad_words_count] }.to_a.reverse.first(number.to_i)
  end
end

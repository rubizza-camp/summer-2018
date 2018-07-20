# Show table of statistic
class TableOfStatistic
  def self.make_table(number)
    rows = DateAnalyzer.stats_of_rappers(number).map do |name, statistic|
      make_rows(name, statistic)
    end

    Terminal::Table.new rows: rows
  end

  def self.make_rows(name, statistic)
    [
      name,
      RussianWords.battles_count_for_raper(statistic[:count]),
      RussianWords.bad_words_count(statistic[:bad_words_count]),
      RussianWords.avg_bad_words(statistic[:avg_bad_words]),
      RussianWords.count_words_in_round(statistic[:count_words_in_rounds])
    ]
  end
end

# Show table of statistic
class TableOfStatistic
  def initialize(number)
    @number = number
  end

  def make_table
    rows = MostObsceneRappersFinder.stats_of_rappers(@number).map do |name, statistic|
      RapperRowPresenter.new(name, statistic).make_rows
    end

    Terminal::Table.new rows: rows
  end
end

# Show table of statistic
class TableOfStatistic
  def initialize(number)
    @number = number
  end

  def make_table
    rows = MostObsceneRappersFinder.new(@number).stats_of_rappers.map { |arr| RapperRowPresenter.new(arr).make_rows }
    Terminal::Table.new rows: rows
  end
end

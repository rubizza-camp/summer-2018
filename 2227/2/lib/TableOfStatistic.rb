# Show table of statistic
class TableOfStatistic
  def initialize(number_rappers)
    @number_rappers = number_rappers
  end

  def make_table
    rows = MostObsceneRappersFinder.new
                                   .most_obscene_rappers.map { |rapper| RapperRowPresenter.new(rapper).make_rows }
                                   .sort_by { |stats| stats[2].split.first.to_i }.reverse.first(@number_rappers.to_i)
    Terminal::Table.new rows: rows
  end
end

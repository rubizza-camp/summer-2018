# This class is used for printing table in terminal
class TablePrinter
  def initialize(top_bad_words)
    @top_bad_words = top_bad_words
    @rapper = RappersList.find_all_rappers.map { |rapper| RapperData.new(rapper) }
                         .sort_by { |word| -word.count_bad_words }
                         .first(@top_bad_words.to_i)
    print_table_to_terminal
  end

  def print_table_to_terminal
    puts make_table
  end

  def make_table
    rows = @rapper.map do |rapper|
      RowPresenter.new(rapper).show_rapper_info
    end
    Terminal::Table.new(rows: rows)
  end
end

# This class is used for printing table to the terminal
class TopBadWordsPrinter
  def initialize(top_bad_words)
    @top_bad_words = top_bad_words
    @rapper = DataStorage.list_all_rappers.map { |rapper| Rapper.new(rapper) }
                         .sort_by { |word| -word.number_of_swear_words }
                         .first(@top_bad_words.to_i)
    puts_table_to_terminal
  end

  def puts_table_to_terminal
    puts make_table
  end

  def make_table
    rows = @rapper.map do |rapper|
      RowPresenter.new(rapper).show_rapper_info
    end
    Terminal::Table.new(rows: rows)
  end
end

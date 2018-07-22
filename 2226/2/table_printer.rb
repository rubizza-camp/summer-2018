# This class is used for printing table to the terminal
class TablePrinter
  def initialize(top_bad_words)
    @top_bad_words = top_bad_words
    @raper = ListOfRapers.list_all_rapers.map { |raper| Raper.new(raper) }
                         .sort_by { |word| -word.number_of_swear_words }
                         .first(@top_bad_words.to_i)
    puts_table_to_terminal
  end

  def puts_table_to_terminal
    puts make_table
  end

  def make_table
    rows = @raper.map do |raper|
      RowPresenter.new(raper).show_raper_info
    end
    Terminal::Table.new(rows: rows)
  end
end

require_relative './top_bad_words_analyzer.rb'

# Class that produces output from TopBadWordsAnalyzer
class TopBadWordsPrinter
  HEADING = ['Name',
             'Amount of battle',
             'Amount of bad words',
             'Amount of bad words on battles',
             'Amount of words on round'].freeze
  FIRST_COLUMN = 0

  def initialize(rappers)
    @rappers = rappers
  end

  def print_top_bad_words
    table = Terminal::Table.new(rows: table_rows_of_sorted_rappers, headings: HEADING)
    table.columns.each_with_index do |_value, index|
      table.align_column(index, :center) if index > FIRST_COLUMN
    end
    puts table
  end

  private

  def row_with_stats(rapper)
    [rapper.name,
     rapper.battles.count,
     rapper.number_of_bad_words,
     rapper.bad_words_on_battle,
     rapper.words_on_round]
  end

  def table_rows_of_sorted_rappers
    rows = @rappers.map do |rapper|
      row_with_stats(rapper)
    end
    rows
  end
end

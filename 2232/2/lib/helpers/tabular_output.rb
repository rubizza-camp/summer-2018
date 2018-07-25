module TabularOutput
  def tabular_output(rows_arr, headings)
    puts Terminal::Table.new(headings: headings, rows: rows_arr.map(&:show))
  end
end

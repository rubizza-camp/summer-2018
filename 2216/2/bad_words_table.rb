class BadWordsTable
  def initialize(bad_words, top_number, columns)
    @bad_words = bad_words
    @top_number = top_number
    @columns = columns
  end

  def print(path)
    top_participant = make_top_participants
    properties = Array.new(@columns) { 0 }
    print_top_participant(top_participant, properties, path)
  end

  private

  def sort_by_bad_words
    @bad_words.sort_by { |_key, value| value[1] }.reverse
  end

  def make_top_participants
    top_participant = []
    @bad_words = sort_by_bad_words
    @top_number.times { top_participant << @bad_words.shift }
    top_participant
  end

  def print_top_participant(top_participant, properties, path)
    get_the_properties_for_grid(top_participant, properties)
    top_participant.each { |participant| print_the_row(participant, properties, path) }
  end

  def get_the_properties_for_grid(participant_in_top, properties_for_cell)
    cell_arrays = Array.new(@columns) { [] }
    participant_in_top.each { |participant_inf| get_name_field(cell_arrays, participant_inf) }
    get_prop_array(properties_for_cell, cell_arrays)
  end

  def get_name_field(cell_arrays, participant_inf)
    cell_arrays[0] << participant_inf[0]
    get_the_rest_properties(cell_arrays, participant_inf)
  end

  def participant_inf_to_string(participant_inf, index)
    participant_inf[1][index - 1] = participant_inf[1][index - 1].to_s
  end

  def get_the_rest_properties(cells, participant_inf)
    1.upto(@columns - 1) do |index|
      cells[index] << participant_inf_to_string(participant_inf, index)
    end
  end

  def get_prop_array(cell_properties_array, cells)
    0.upto(@columns - 1) do |index|
      cell_properties_array[index] = cells[index].max_by(&:size).size + 1
    end
  end

  def print_the_row(participant_in_top, properties, path)
    to_consol = path == :console
    row = ''
    row += make_cell(participant_in_top[0], '', properties[0]) + '|' +
           get_the_rest_inf_for_row(row, participant_in_top, properties)
    if to_consol
      puts row
    else
      put_in_file(row, path)
    end
  end

  def put_in_file(row, path)
    File.open(path, 'a') { |line| line.puts row }
  end

  def make_cell(criterion, column_name, prop_cell_size)
    cell = criterion + column_name
    cell += ' ' while cell.size != prop_cell_size + column_name.size
    cell
  end

  def get_the_rest_inf_for_row(row, participant_in_top, props)
    column_names = [' баттлов', ' нецензурных слов', ' слов на баттл', ' слов в раунде']
    0.upto(@columns - 2) do |index|
      row += make_cell(participant_in_top[1][index], column_names[index], props[index + 1]) + '|'
    end
    row
  end
end

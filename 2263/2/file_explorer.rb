# Factory, that explores one file with text and creates fully initialized Battle object
class FileExplorer
  def initialize(file, pattern = /((Р|р)аунд \d)|(\d (Р|р)аунд)/)
    @file = check_file(file)
    @round_description_pattern = pattern
  end

  def explore
    line_counter = 0
    @file.each_with_object(Battle.new) do |file_line, battle|
      line = Line.new(file_line, line_counter += 1)
      explore_line(line, battle)
    end
  end

  private

  def check_file(file)
    file.is_a?(File) ? file : raise(VersusExceptions::VersusFileError, file)
  end

  def explore_line(line, battle)
    if line.match_pattern?(@round_description_pattern)
      battle.add_round(Round.new)
    else
      battle.add_round(Round.new) if line.first?
      add_line_to_last_round(line, battle)
    end
  end

  def add_line_to_last_round(line, battle)
    line.word_objects.each { |word| battle.rounds_list.last.add_word(word) }
  end
end

# One line in file
class Line
  attr_reader :number_in_file, :line, :words

  def initialize(line, number_in_file)
    @number_in_file = number_in_file
    @line = line
    @words = to_word_array
  end

  def first?
    number_in_file == 1
  end

  def match_pattern?(pattern)
    pattern.match?(@line)
  end

  def word_objects
    @words.reduce([]) { |word_objects, word| word_objects << Word.new(word) }
  end

  private

  def to_word_array
    line = @line.split(/[^[[:word:]]\*]+/)
    line.delete_if { |word| word == '' }
  end
end

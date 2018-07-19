# Class, that takes file with battle text, counts number of rounds, and makes the list of all words
class Battle
  attr_reader :file
  attr_reader :rounds_number, :all_words

  def initialize(file)
    @file = check_file(file)
    @rounds_number = 0
    @all_words = []
    inspect_file
  end

  private

  def check_file(file)
    file.class == File ? file : raise(BattleFileError, file)
  end

  def inspect_file
    @file.each do |line|
      round_description?(line) ? @rounds_number += 1 : @all_words += to_word_array(line)
    end
    @rounds_number = 1 if @rounds_number.zero?
  end

  def to_word_array(line)
    line.split(/[^[[:word:]]\*]+/)
  end

  # Check if the line is round description
  def round_description?(line)
    return true if line =~ /(^(Р|р)аунд \d)|(^\d (Р|р)аунд)/
    false
  end
end

# Exception, that is raised when Battle argument is not a File object
class BattleFileError < StandardError
  def initialize(file, message = nil)
    @file = file
    @message = message ? default_message : message
  end

  private

  def default_message
    "Error. #{@file} is not a File object"
  end
end

# Class which helps to count words only (unions etc. are excluded)
class TopWordHelper
  def initialize(file_name, marker)
    @no_word_array = read_from_file(file_name, marker)
    @word_count = Hash.new(0)
  end

  def read_from_file(file_name, marker)
    YAML.safe_load(File.open(file_name).read)[marker]
  end

  attr_reader :no_word_array, :word_count

  def increase_word_counter(key)
    @word_count[key] += 1
  end
end
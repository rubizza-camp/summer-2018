# Class for comparing names
class NameCheck
  attr_reader :first_name, :second_name
  def initialize(first_name, second_name)
    @first_name = first_name
    @second_name = second_name
  end

  def name_check
    size = size_compare
    part_size = 0
    part_size = size / 3.to_i if size > 3
    size_difference = size - part_size
    first_name[0..size_difference] == second_name[0..size_difference]
  end

  private

  def size_compare
    fsize = first_name.size
    ssize = second_name.size
    hash_size = { true => fsize, false => ssize }
    hash_size[fsize > ssize]
  end
end

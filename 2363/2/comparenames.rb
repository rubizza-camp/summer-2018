# There are methods which dont use instances
class CompareNames
  attr_reader :first_name, :second_name

  def initialize(first_name, second_name)
    @first_name = first_name
    @second_name = second_name
  end

  def call
    size = count_avg_size
    check_size = (0..(size - (size > 3 ? size / 3 : 0)))
    first_name[check_size].eql?(second_name[check_size])
  end

  private

  def count_avg_size
    first_size = first_name.size
    second_size = second_name.size
    first_size > second_size ? first_size : second_size
  end
end

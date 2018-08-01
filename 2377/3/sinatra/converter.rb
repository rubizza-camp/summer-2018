# Converts things
class Converter
  attr_reader :value
  attr_reader :final_value
  def initialize(value)
    @value = value
    @final_value = convert
  end

  def convert
    proportion = 1 / value
    200 / proportion - 100
  end
end

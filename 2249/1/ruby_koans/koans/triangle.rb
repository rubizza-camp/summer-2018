# Triangle Project Code.

# Triangle analyzes the lengths of the sides of a triangle
# (represented by a, b and c) and returns the type of triangle.
#
# It returns:
#   :equilateral  if all sides are equal
#   :isosceles    if exactly 2 sides are equal
#   :scalene      if no sides are equal
#
# The tests for this method can be found in
#   about_triangle_project.rb
# and
#   about_triangle_project_2.rb
#
# def triangle(a, b, c)
#   s = (a + b + c) / 2
#   correct = (s - a) * (s - b) * (s - c)
#   TriangleError if a <= 0 || b <= 0 || c <= 0 || correct <= 0
#
#   if a == b && b == c
#     :equaliteral
#   elsif a == b || a == c || b == c
#     :isosceles
#   else
#     :scalene
#   end
# end
# :reek:FeatureEnvy
# :reek:UncommunicativeParameterName
# :reek:UncommunicativeVariableName
def triangle(side_a, side_b, side_c)
  triangle = Triangle.new(side_a, side_b, side_c)
  raise TriangleError unless triangle.valid?
  triangle.type
end

# Represents triangle
class Triangle
  TYPES_OF_TRIANGLES = {
    1 => :equaliteral,
    2 => :isosceles,
    3 => :scalene
  }.freeze

  def initialize(side_a, side_b, side_c)
    @side_a, @side_b, @side_c = [side_a, side_b, side_c].sort
  end

  def valid?
    sides_length_positive? && sides_lengths_correct?
  end

  def type
    TYPES_OF_TRIANGLES[unique_sides_number]
  end

  private

  def unique_sides_number
    [@side_a, @side_b, @side_c].uniq.size
  end

  def sides_length_positive?
    @side_a > 0 && @side_b > 0 && @side_c > 0
  end

  def sides_lengths_correct?
    @side_a + @side_b > @side_c
  end
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end

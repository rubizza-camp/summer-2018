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
# :reek:UncommunicativeParameterName
# rubocop:disable Metrics/PerceivedComplexity,Metrics/CyclomaticComplexity
def triangle(side_a, side_b, side_c)
  # WRITE THIS CODE
  raise TriangleError if sides_non_positive?(side_a, side_b, side_c) ||
                         sum_non_greater_third_side?(side_a, side_b, side_c)

  if side_a == side_b && side_b == side_c
    :equilateral
  elsif side_b == side_a || side_c == side_b || side_a == side_c
    return :isosceles
  else
    :scalene
  end
end

# :reek:UtilityFunction
# rubocop:enable Metrics/PerceivedComplexity,Metrics/CyclomaticComplexity
def sides_non_positive?(side_a, side_b, side_c)
  side_a <= 0 || side_b <= 0 || side_c <= 0
end

# :reek:UtilityFunction
def sum_non_greater_third_side?(side_a, side_b, side_c)
  side_a + side_b <= side_c || side_a + side_c <= side_b || side_b + side_c <= side_a
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end

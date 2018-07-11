# Triangle Project Code.
# :reek:UncommunicativeParameterName
# :reek:UncommunicativeVariableName
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
# :reek:TooManyStatements
# :reek:FeatureEnvy
def triangle_raise_error(side_a, side_b, side_c)
  triangle_sides = [side_a, side_b, side_c].sort
  raise TriangleError if triangle_sides.first <= 0
  raise TriangleError if triangle_sides.take(2).sum <= triangle_sides.last
end

# :reek:FeatureEnvy
def triangle(side_a, side_b, side_c)
  triangle_raise_error(side_a, side_b, side_c)
  if side_a == side_b && side_b == side_c
    :equilateral
  elsif side_a == side_b || side_b == side_c || side_c == side_a
    :isosceles
  else
    :scalene
  end
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end

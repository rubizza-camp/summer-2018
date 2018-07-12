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

# This method smells of :reek:FeatureEnvy
def triangle_error(side_a, side_b, side_c)
  raise TriangleError if side_a + side_b <= side_c || side_b == side_a + side_c || [side_a, side_b, side_c].min < 0
end

# This method smells of :reek:FeatureEnvy
def triangle(side_a, side_b, side_c)
  triangle_error(side_a, side_b, side_c)
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

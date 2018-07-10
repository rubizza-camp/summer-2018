# Triangle Project Code.

# Triangle analyzes the lengths of the sides of side_a triangle
# (represented by side_a, side_b and side_c) and returns the type of triangle.
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

# This method smells of :reek:UtilityFunction
def triangle_type(side_a, side_b, side_c)
  if (side_a == side_b) && (side_b == side_c)
    :equilateral
  elsif (side_a != side_b) && (side_a != side_c) && (side_b != side_c)
    :scalene
  else
    :isosceles
  end
end

# This method smells of :reek:FeatureEnvy
def triangle(side_a, side_b, side_c)
  # WRITE THIS CODE
  raise TriangleError if (side_a >= side_b + side_c) || (side_b >= side_a + side_c) || (side_c >= side_a + side_b)

  triangle_type(side_a, side_b, side_c)
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end

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
#
# This method smells of :reek:FeatureEnvy
def triangle(first, second, third)
  # WRITE THIS CODE
  #--
  first, second, third = [first, second, third].sort
  raise TriangleError if (first + second) <= third
  sides = [first, second, third].uniq
  [nil, :equilateral, :isosceles, :scalene][sides.size]
  #++
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end

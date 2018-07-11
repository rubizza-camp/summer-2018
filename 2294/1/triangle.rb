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
# :reek:FeatureEnvy
# :reek:TooManyStatements
def triangle(side_one, side_two, side_three)
  parameters = [side_one, side_two, side_three].sort

  raise TriangleError if parameters.first <= 0
  raise TriangleError if parameters.take(2).sum <= parameters.last

  triangles = { 3 => :scalene, 2 => :isosceles, 1 => :equilateral }
  triangles[parameters.uniq.size]
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end

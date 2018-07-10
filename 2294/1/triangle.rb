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
  parameters = [side_one, side_two, side_three]

  raise TriangleError if parameters.min <= 0
  raise TriangleError if parameters.sort.take(2).sum <= parameters.max

  case parameters.uniq.size
  when 1 then :equilateral
  when 2 then :isosceles
  when 3 then :scalene
  end
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end

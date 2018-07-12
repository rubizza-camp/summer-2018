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
# This method smells of :reek:UtilityFunction
# This method smells of :reek:FeatureEnvy
# This method smells of :reek:TooManyStatements
def triangle(*sides)
  sides.sort!
  raise TriangleError if sides.any?(&:negative?) || ((sides[0] + sides[1]) <= sides[2])
  sides.uniq!
  hash = Hash.new(:scalene).merge!(1 => :equilateral, 2 => :isosceles)
  hash[sides.count]
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end

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
# This method smells of :reek:TooManyStatements
def triangle_check_error(sides_to_check)
  raise TriangleError if sides_to_check.count != 3
  sorted_sides_to_check = sides_to_check.sort
  sorted_sides_sum_check = (sorted_sides_to_check[0] + sorted_sides_to_check[1]) > sorted_sides_to_check[2]
  raise TriangleError if sorted_sides_to_check.any? { |side| side <= 0 }
  raise TriangleError unless sorted_sides_sum_check
end

UNIQUE_SIDES_COUNT_TO_TRIANGLE_TYPE_MAP = { 1 => :equilateral, 2 => :isosceles, 3 => :scalene }.freeze

# This method smells of :reek:UtilityFunction
# This method smells of :reek:FeatureEnvy
# This method smells of :reek:TooManyStatements
def triangle(*sides)
  triangle_check_error(sides)
  unique_sides_count = sides.uniq.count
  UNIQUE_SIDES_COUNT_TO_TRIANGLE_TYPE_MAP[unique_sides_count]
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end

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
# rubocop:disable Metrics/CyclomaticComplexity
# This method smells of :reek:FeatureEnvy

def check_sides(first_side, second_side, third_side)
  raise TriangleError, 'No negative or null sides' if first_side <= 0 || second_side <= 0 || third_side <= 0
  raise TriangleError, 'Triangle with that sides can\'t exist' unless first_side < second_side + third_side\
   && second_side < first_side + third_side && third_side < first_side + second_side
end

# rubocop:enable Metrics/CyclomaticComplexity
# This method smells of :reek:UtilityFunction
# This method smells of :reek:FeatureEnvy
# This method smells of :reek:TooManyStatements
def triangle(first_side, second_side, third_side)
  check_sides(first_side, second_side, third_side)
  return :equilateral if first_side == second_side && second_side == third_side
  return :isosceles if first_side == second_side || first_side == third_side || second_side == third_side
  :scalene
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end

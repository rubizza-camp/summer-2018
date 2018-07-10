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
# This method smells of :reek:DuplicateMethodCall
# This method smells of :reek:FeatureEnvy
# This method smells of :reek:TooManyStatements
def triangle(a_side, b_side, c_side)
  # WRITE THIS CODE
  raise TriangleError, "triangle doesn't exist" if a_side.zero? || b_side.zero? || c_side.zero?
  raise TriangleError, "triangle doesn't exist" if a_side + b_side <= c_side || a_side + c_side <= b_side || b_side + c_side <= a_side
  raise TriangleError, "triangle doesn't exist" if a_side <= 0 || b_side <= 0 || c_side <= 0
  # This method smells of :reek:DuplicateMetodCall
  return :equilateral if a_side == c_side && b_side == c_side && a_side == b_side
  return :isosceles if a_side == b_side || b_side == c_side || a_side == c_side
  :scalene
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end

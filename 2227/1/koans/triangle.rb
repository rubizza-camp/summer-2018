# frozen_string_literal: true

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
# This method smells of :reek:DuplicateMethodCall
# This method smells of :reek:UncommunicativeParameterName
# This method smells of :reek:FeatureEnvy
def triangle(*sides)
  sides.sort!
  raise TriangleError if sides.any? { |edge| edge <= 0 }
  raise TriangleError if sides[2] >= sides[0] + sides[1]
  { 1 => :equilateral, 2 => :isosceles, 3 => :scalene }[sides.uniq.size]
end
# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end

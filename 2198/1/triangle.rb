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
# This method smells of :reek:FeatureEnvy
# This method smells of :reek:UncommunicativeParameterName
# rubocop:disable UncommunicativeMethodParamName
# rubocop:disable Metrics/PerceivedComplexity
# rubocop:disable Metrics/CyclomaticComplexity
# rubocop:disable Metrics/AbcSize
def triangle(a, b, c)
  raise TriangleError if a <= 0 || b <= 0 || c <= 0 || a + b <= c || a + c <= b || b + c <= a
  if a == b && a == c
    :equilateral
  elsif a == b || b == c || a == c
    :isosceles
  else
    :scalene
  end
end
# rubocop:enable UncommunicativeMethodParamName
# rubocop:enable Metrics/PerceivedComplexity
# rubocop:enable Metrics/CyclomaticComplexity
# rubocop:enable Metrics/AbcSize

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end

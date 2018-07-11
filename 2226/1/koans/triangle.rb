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
# rubocop:disable Metrics/PerceivedComplexity
# rubocop:disable Metrics/CyclomaticComplexity
# rubocop:disable Metrics/LineLength
# :reek:DuplicateMethodCall
# :reek:FeatureEnvy
def triangle(alpha, beta, centra)
  raise TriangleError, 'The triangle is not valid' unless (alpha + beta) > centra && (alpha + centra) > beta && (beta + centra) > alpha
  if alpha == beta && beta == centra
    :equilateral
  elsif alpha == beta || beta == centra || alpha == centra
    :isosceles
  else
    :scalene
  end
end
# Error class used in part 2. No need to change this code.
class TriangleError < StandardError
end
# rubocop:enable Metrics/PerceivedComplexity
# rubocop:enable Metrics/CyclomaticComplexity
# rubocop:enable Metrics/LineLength

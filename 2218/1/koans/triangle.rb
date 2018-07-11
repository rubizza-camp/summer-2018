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
# rubocop:disable Metrics/PerceivedComplexity
# rubocop:disable Metrics/CyclomaticComplexity
def triangle(aaa, bbb, ccc)
  xxx, yyy, zzz = [aaa, bbb, ccc].sort
  raise TriangleError if xxx <= 0 || xxx + yyy <= zzz
  if aaa == bbb && bbb == ccc
    :equilateral
  elsif aaa == bbb || bbb == ccc || aaa == ccc
    :isosceles
  else
    :scalene
  end
end
# rubocop:enable Metrics/PerceivedComplexity
# rubocop:enable Metrics/CyclomaticComplexity

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end

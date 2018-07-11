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
# This method smells of :reek:UtilityFunction
# This method smells of :reek:FeatureEnvy
def triangle(aaa, bbb, ccc)
  triangle_validation(aaa, bbb, ccc)
  if aaa == bbb && aaa == ccc
    :equilateral
  elsif aaa == bbb || aaa == ccc || bbb == ccc
    :isosceles
  else
    :scalene
  end
end

# This method smells of :reek:UtilityFunction
# This method smells of :reek:FeatureEnvy
def triangle_validation(aaa, bbb, ccc)
  raise TriangleError if (aaa + bbb) <= ccc || (aaa + ccc) <= bbb || (bbb + ccc) <= aaa
end
# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError; end

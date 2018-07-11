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
def triangle(aa, bb, cc)
  triangle_validation(aa, bb, cc)
  if aa == bb && aa == cc
    :equilateral
  elsif aa == bb || aa == cc || bb == cc
    :isosceles
  else
    :scalene
  end
end

def triangle_validation(aa, bb, cc)
  raise TriangleError if (aa + bb) <= cc || (aa + cc) <= bb || (bb + cc) <= aa
end
# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError; end

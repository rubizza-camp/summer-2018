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
def triangle(a, b, c)
  [a, b, c].permutation do |sides|
    raise TriangleError unless sides[0] + sides[1] > sides[2]
  end
  case [a,b,c].uniq.size
    when 3; :scalene
    when 2; :isosceles
    when 1; :equilateral
  end
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end

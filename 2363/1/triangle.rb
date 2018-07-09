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
def triangle(side_a, side_b, side_c)
  avg = (side_a + side_b + side_c) / 2.0    
  test = (avg - a) * (avg - b) * (avg - c)  
  if a <= 0 || b <= 0 || c <= 0 || test <= 0
    raise TriangleError
  end
  answer(side_a, side_b, side_c)
end
  
def answer(side_a, side_b, side_c)
  if (a == b) && (b == c)
    :equilateral
  elsif (a == b) || (b == c) || (a == c)
    :isosceles
  else
    :scalene
  end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end

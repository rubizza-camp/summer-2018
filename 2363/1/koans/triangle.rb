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
  s = (a + b + c) / 2.0    
  test = (s - a) * (s - b) * (s - c)  
  if a <= 0 or b <= 0 or c <= 0 or test <= 0 then 
    raise TriangleError
  end
  if (a == b) and (b == c)
    :equilateral 
  elsif (a == b) or (b == c) or (a == c)
    :isosceles 
  else :scalene
  end
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
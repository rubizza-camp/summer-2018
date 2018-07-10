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
  if a <= 0 || b <= 0 || c <= 0
    raise TriangleError, "sides cant't be less then 0"
  end

  if a + b <= c || a + c <= b || b + c <= a
    raise TriangleError, " two sides cant't be less then one"
  end
  ans = %i[scalene isosceles isosceles equilateral]
  i = 0
  i += 1 if a == b
  i += 1 if a == c
  i += 1 if b == c
  ans[i]
 end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end

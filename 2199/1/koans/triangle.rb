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
  raise TriangleError if invalid_dimensions?(a, b, c) || invalid_triangle?(a, b, c)
  classify_valid_triangle(a, b, c)
end

def classify_valid_triangle(a, b, c)
  if a == b && a == c
    :equilateral
  elsif a == b || b == c || a == c
    :isosceles
  else
    :scalene
  end
end

def invalid_dimensions?(a, b, c)
  a <= 0 || b <= 0 || c <= 0
end

def invalid_triangle?(a, b, c)
  a + b <= c || b + c <= a || a + c <= b
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end

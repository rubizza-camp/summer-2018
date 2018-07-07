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
def triangle(first, second, third)
  raise TriangleError if invalid_dimensions?(first, second, third) || invalid_triangle?(first, second, third)
  classify_valid_triangle(first, second, third)
end

def classify_valid_triangle(first, second, third)
  if first == second && first == third
    :equilateral
  elsif first == second || second == third || first == third
    :isosceles
  else
    :scalene
  end
end

def invalid_dimensions?(first, second, third)
  first <= 0 || second <= 0 || third <= 0
end

def invalid_triangle?(first, second, third)
  first + second <= third || second + third <= first || first + third <= second
end

# Error class used in part 2. No need to change this code.
class TriangleError < StandardError
end

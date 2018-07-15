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
def triangle(a_line, b_line, c_line)
  triangle_zero_error(a_line, b_line, c_line)
  triangle_sides_error(a_line, b_line, c_line)
  if (a_line == b_line) && (b_line == c_line)
    :equilateral
  elsif (a_line == b_line) || (a_line == c_line) || (b_line == c_line)
    :isosceles
  else
    :scalene
  end
end

def triangle_zero_error(a_line, b_line, c_line)
  raise TriangleError if a_line <= 0 || b_line <= 0 || c_line <= 0
end

# :reek:FeatureEnvy
def triangle_sides_error(a_line, b_line, c_line)
  raise TriangleError if a_line + b_line <= c_line || a_line + c_line <= b_line || b_line + c_line <= a_line
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end

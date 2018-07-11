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
# This method smells of :reek:UtilityFunction
# This method smells of :reek:FeatureEnvy
def triangle(a_size, b_size, c_size)
  triangle_erros(a_size, b_size, c_size)
  if (a_size == b_size) && (b_size == c_size)
    :equilateral
  elsif (a_size == b_size) || (a_size == c_size) || (b_size == c_size)
    :isosceles
  else
    :scalene
  end
end
# This method smells of :reek:UtilityFunction
# This method smells of :reek:FeatureEnvy

def triangle_erros(a_size, b_size, c_size)
  raise TriangleError if (a_size + b_size <= c_size) || (a_size + c_size <= b_size) || (b_size + c_size <= a_size)
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end

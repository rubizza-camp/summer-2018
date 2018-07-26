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
# :reek:DuplicateMethodCall
def triangle(param_a, param_b, param_c)
  raise TriangleError if [param_a, param_b, param_c].min <= 0
  first_min, second_min, greater_then_all = [param_a, param_b, param_c].sort
  raise TriangleError if first_min + second_min <= greater_then_all

  %i[equilateral isosceles scalene].fetch [param_a, param_b, param_c].uniq.size - 1
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end

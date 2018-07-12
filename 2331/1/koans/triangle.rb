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
# :reek:FeatureEnvy
# :reek:TooManyStatements
# :reek:ControlParameter
# :reek:UtilityFunction
def isosceles?(side_a, side_b, side_c)
  side_a == side_b || side_a == side_c || side_b == side_c
end

# :reek:ControlParameter
# :reek:UtilityFunction
def equilateral?(side_a, side_b, side_c)
  side_a == side_b && side_a == side_c
end

# :reek:ControlParameter
# :reek:UtilityFunction
def scalene?(side_a, side_b, side_c)
  side_a != side_b && side_a != side_c
end

def triangle(first_side, second_side, third_side)
  raise TriangleError if [first_side, second_side, third_side].min <= 0
  side_a, side_b, side_c = [first_side, second_side, third_side].sort
  raise TriangleError if side_a + side_b <= side_c
  %i[equilateral isosceles scalene].find { |type| send("#{type}?", side_a, side_b, side_c) }
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end

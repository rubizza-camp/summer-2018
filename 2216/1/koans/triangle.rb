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

# This method smells of :reek:UtilityFunction
def identify_kind_of_triangle(first_side, second_side, third_side)
  if first_side == second_side && first_side == third_side
    :equilateral
  elsif first_side == second_side || first_side == third_side || second_side == third_side
    :isosceles
  else
    :scalene
  end
end

# This method smells of :reek:UtilityFunction
def check_triangle(first_side, second_side, third_side)
  # if one number zero then the product is zero
  side_is_zero = (first_side * second_side * third_side).zero?
  # if one number negative then the product is negative
  side_is_negative = (first_side * second_side * third_side).negative?
  sum_less_side = (first_side + second_side <= third_side || first_side + third_side <= second_side ||
     second_side + third_side <= first_side)
  side_is_zero || side_is_negative || sum_less_side
end

def triangle(first_side, second_side, third_side)
  triangle_is_right = true
  triangle_is_right = false if check_triangle(first_side, second_side, third_side)

  raise TriangleError unless triangle_is_right
  identify_kind_of_triangle(first_side, second_side, third_side)
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end

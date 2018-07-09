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
# This method smells of :reek:UncommunicativeMethodName
# This method smells of :reek:UncommunicativeVariableName
# This method smells of :reek:TooManyStatements
# This method smells of :reek:FeatureEnvy
def triangle(first_side, second_side, third_side)
  if [first_side, second_side,third_side].any? {|x| x <= 0}
  raise TriangleError, 'Sides must have positive length' 
  end

  sides = [first_side, second_side, third_side].sort

  unless sides[0] + sides[1] > sides[2]
  raise TriangleError, 'Does not satisfy triangle inequality'
  end

  case 
    when first_side == second_side && second_side == third_side
      return :equilateral
    when first_side == second_side || second_side == third_side || first_side == third_side
      return :isosceles
    else
      return :scalene
  end
end

# Error class used in part 2.  No need to change this code.
# This class smells of :reek:UncommunicativeModuleName
class TriangleError < StandardError
end

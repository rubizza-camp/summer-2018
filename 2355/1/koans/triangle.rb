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
# rubocop:disable Style/IfUnlessModifier
# rubocop:disable Style/EmptyCaseCondition
# rubocop:disable Layout/CaseIndentation
# This method smells of :reek:UtilityFunction
# This method smells of :reek:DuplicateMethodCall
def kind_of_triangle(first_side, second_side, third_side)
  case
    when first_side == second_side && second_side == third_side
      :equilateral
    when first_side == second_side || second_side == third_side || first_side == third_side
      :isosceles
    else
      :scalene
  end
end

# This method smells of :reek:UncommunicativeVariableName
# This method smells of :reek:UtilityFunction
def triangle(first_side, second_side, third_side)
  if [first_side, second_side, third_side].any? { |x| x <= 0 }
    raise TriangleError, 'Sides must have positive length'
  end

  sorted_sides = [first_side, second_side, third_side].sort

  unless sorted_sides[0] + sorted_sides[1] > sorted_sides[2]
    raise TriangleError, 'Does not satisfy triangle inequality'
  end

  kind_of_triangle(first_side, second_side, third_side)
end

# Error class used in part 2.  No need to change this code.
# This class smells of :reek:UncommunicativeModuleName
class TriangleError < StandardError
end
# rubocop:enable Style/IfUnlessModifier
# rubocop:enable Style/EmptyCaseCondition
# rubocop:enable Layout/CaseIndentation

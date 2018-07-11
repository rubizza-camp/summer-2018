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
# This method smells of :reek:FeatureEnvy
# This method smells of :reek:UncommunicativeMethodName
# This method smells of :reek:UncommunicativeVariableName
# This method smells of :reek:TooManyStatements
# This method smells of :reek:FeatureEnvy
def select_type_triangle(per_a, per_b, per_c)
  if per_a == per_b && per_b == per_c
    :equilateral
  elsif per_a == per_b || per_a == per_c || per_b == per_c
    :isosceles
  else
    :scalene
  end
end

# This method smells of :reek:UtilityFunction
# This method smells of :reek:FeatureEnvy
# This method smells of :reek:UncommunicativeMethodName
# This method smells of :reek:UncommunicativeVariableName
# This method smells of :reek:TooManyStatements
# This method smells of :reek:FeatureEnvy
def triangle(per_a, per_b, per_c)
  s = (per_a + per_b + per_c) / 2.0
  # the following must be positive to be a valid triangle
  ok = (s - per_a) * (s - per_b) * (s - per_c)

  raise TriangleError if per_a <= 0 || per_b <= 0 || per_c <= 0 || ok <= 0

  select_type_triangle(per_a, per_b, per_c)
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end

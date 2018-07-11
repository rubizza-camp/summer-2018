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
# This method smells of :reek:TooManyStatements
def triangle(side_a, side_b, side_c)
  # WRITE THIS CODE

  sides = [side_a, side_b, side_c].sort
  raise TriangleError if sides.any? { |side| side <= 0 }
  raise TriangleError unless (sides[0] + sides[1]) > sides[2]
  sides.uniq!
  hash = Hash.new(:scalene)
  hash[1] = :equilateral
  hash[2] = :isosceles
  hash[sides.count]

  # s = (side_a + side_b + side_c) / 2.0
  # ok = (s - side_a) * (s - side_b) * (s - side_c)
  # if side_a <= 0 || side_b <= 0 || side_c <= 0 || ok <= 0 then
  #   raise TriangleError
  # end
  # if side_a == side_b && side_b == side_c then
  #   :equilateral
  # elsif side_a == side_b || side_a == side_c || side_b == side_c then
  #   :isosceles
  # else
  #   :scalene
  # end
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end

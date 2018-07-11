# rubocop:disable all
# :reek:FeatureEnvy
# :reek:UncommunicativeParameterName
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
# :reek:UncommunicativeParameterName
# :reek:TooManyStatements
def triangle(*sides)
	validate_sides(*sides)
	sides.uniq!
	sides_hash = Hash.new(:scalene).merge!(1 => :equilateral, 2 => :isosceles)
	sides_hash[sides.count]
end
# :reek:FeatureEnvy
def validate_sides(*sides)
	raise TriangleError, "Sides length can't be negative!" if sides.any?(&:negative?)
	sides.sort!
	raise TriangleError, "Triangle with this sides can't exist!" if (sides[2] >= sides[1] + sides[0])
end
# Error class used in part 2.  No need to change this code.
# :reek:FeatureEnvy
# :reek:UncommunicativeParameterName
class TriangleError < StandardError
end
# rubocop:enable all
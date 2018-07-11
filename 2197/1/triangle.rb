# rubocop:disable all
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
def triangle(a, b, c)

	if a < 0
		raise TriangleError
	elsif a + b <= c or a + c <= b or b + c <= a
		raise TriangleError
	elsif a == c and a == b
		return :equilateral 
	elsif a == b or b == c or c == a
		return :isosceles
	end
	:scalene
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
# rubocop:enable all

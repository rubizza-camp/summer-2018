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
def triangle(a, b, c)
	if [a,b,c].any? {|x| x <= 0}
   	raise TriangleError, 'Sides must have positive length' 
	end

	sides = [a,b,c].sort

   unless sides[0] + sides[1] > sides[2]
   	raise TriangleError, 'Does not satisfy triangle inequality'
	end

	case 
		when a == b&&b == c
			return :equilateral
		when a == b||b == c||a == c
			return :isosceles
		else
			return :scalene
	end
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end

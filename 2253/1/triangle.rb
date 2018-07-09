# Triangle Project Code.

# Triangle analyzes the lengths of the sides of a triangle
# (represented by a, b and c) and returns the type of triangle.
#
# It returns:
#   :equilateral  if all sides are equal
#   :isosceles    if exactly 2 sides are equal
#   :scalene      if no sides are equal
#
def triangle(first, second, third)
  raise TriangleError if [first,second,third].min <= 0 || first + second <= third || first + third <= second || second + third <= first
  if first == second
    if first == third
      :equilateral
    else
      :isosceles
    end
  elsif first == third
    :isosceles
  elsif second == third
    :isosceles
  else
    :scalene
  end
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end

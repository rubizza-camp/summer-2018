# :reek:UncommunicativeParameterName
# :reek:UncommunicativeVariableName
def triangle(side_a, side_b, side_c)
  side_a, side_b, side_c = [side_a, side_b, side_c].sort
  raise TriangleError if (side_a + side_b) <= side_c
  sides = [side_a, side_b, side_c].uniq
  [nil, :equilateral, :isosceles, :scalene][sides.size]
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end

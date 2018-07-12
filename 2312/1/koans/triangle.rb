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
# rubocop:disable Metrics/CyclomaticComplexity
# rubocop:disable Metrics/PerceivedComplexity
# :reek:FeatureEnvy
# :reek:UtilityFunction

def not_positive_sides?(side_one, side_two, side_three)
  side_one <= 0 || side_two <= 0 || side_three <= 0
end

# :reek:UtilityFunction
def bad_sides_sum?(side_one, side_two, side_three)
  side_one + side_two <= side_three ||
    side_two + side_three <= side_one ||
    side_one + side_three <= side_two
end

def errors?(side_one, side_two, side_three)
  not_positive_sides?(side_one, side_two, side_three) ||
    bad_sides_sum?(side_one, side_two, side_three)
end

# :reek:FeatureEnvy
def triangle(side_one, side_two, side_three)
  raise TriangleError if errors?(side_one, side_two, side_three)
  if side_one == side_two && side_two == side_three
    :equilateral
  elsif side_one != side_two && side_one != side_three && side_two != side_three
    :scalene
  else
    :isosceles
  end
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
# rubocop:enable Metrics/CyclomaticComplexity
# rubocop:enable Metrics/PerceivedComplexity
# :reek:FeatureEnvy

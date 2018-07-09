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
<<<<<<< HEAD
=======
<<<<<<< HEAD
# rubocop:disable Style/GuardClause
# rubocop:disable Metrics/MethodLength
# rubocop:disable Metrics/AbcSize
# rubocop:disable Metrics/CyclomaticComplexity
# rubocop:disable Metrics/PerceivedComplexity
# rubocop:disable Style/IfInsideElse
>>>>>>> Done all koans + checked rubocop & reek
# :reek:FeatureEnvy
def check_data(fst, scnd, thrd)
  if (fst <= 0) || (scnd <= 0) || (thrd <= 0)
    raise TriangleError,
          'one (or more) side(s) is(are) lower then (equal to) 0'
  elsif (fst + scnd <= thrd) || (scnd + thrd <= fst) || (fst + thrd <= scnd)
    raise TriangleError,
          'sum of 2 sides is lower then (equal to) the third side'
  end
end

# :reek:FeatureEnvy
def triangle(fst, scnd, thrd)
  check_data fst, scnd, thrd
  if (fst == scnd) && (scnd == thrd)
    return :equilateral
  elsif (fst != scnd) && (fst != thrd) && (scnd != thrd)
    return :scalene
  else
    return :isosceles
  end
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
<<<<<<< HEAD
=======
# rubocop:enable Style/GuardClause
# rubocop:enable Metrics/MethodLength
# rubocop:enable Metrics/AbcSize
# rubocop:enable Metrics/CyclomaticComplexity
# rubocop:enable Metrics/PerceivedComplexity
# rubocop:enable Style/IfInsideElse
=======
# :reek:FeatureEnvy
def check_data(fst, scnd, thrd)
  if (fst <= 0) || (scnd <= 0) || (thrd <= 0)
    raise TriangleError,
          'one (or more) side(s) is(are) lower then (equal to) 0'
  elsif (fst + scnd <= thrd) || (scnd + thrd <= fst) || (fst + thrd <= scnd)
    raise TriangleError,
          'sum of 2 sides is lower then (equal to) the third side'
  end
end

# :reek:FeatureEnvy
def triangle(fst, scnd, thrd)
  check_data fst, scnd, thrd
  if (fst == scnd) && (scnd == thrd)
    return :equilateral
  elsif (fst != scnd) && (fst != thrd) && (scnd != thrd)
    return :scalene
  else
    return :isosceles
  end
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
>>>>>>> Done all koans + checked rubocop & reek
>>>>>>> Done all koans + checked rubocop & reek

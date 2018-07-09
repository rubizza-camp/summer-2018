# Triangle Project Code.

# Triangle analyzes the lengths of the sides of a triangle
# (represented by a, b and c) and returns the type of triangle.
#
# It returns:
#   :equilateral  if all sides are equal
#   :isosceles    if exactly 2 sides are equal
#   :scalene      if no sides are equal
#
def triangle(fir, sec, thi)
  raise TriangleError if [fir, sec, thi].min <= 0 || fir + sec <= thi || fir + thi <= sec || sec + thi <= fir
  if fir == sec
    if fir == thi
      :equilateral
    else
      :isosceles
    end
  elsif fir == thi
    :isosceles
  elsif sec == thi
    :isosceles
  else
    :scalene
  end
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end

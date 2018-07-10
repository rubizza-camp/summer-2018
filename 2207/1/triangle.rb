# :reek:TooManyStatements
# :reek:FeatureEnvy
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
def triangle(side_a, side_b, side_c)
  
  fail TriangleError if side_a==0 || side_b==0 || side_c==0
  fail TriangleError if side_a < 0 || side_b < 0 || side_c < 0
  fail TriangleError if (side_a+side_b) <= side_c
    fail TriangleError if (side_a+side_c) <= side_b
  
  if side_a==side_b && side_b==side_c
      return :equilateral
  elsif side_a==side_b || side_b==side_c || side_a==side_c
      return :isosceles
  else
      return :scalene
  end
  
  #raise TriangleError, "wtf dose whith this triangle)" if a=b=c==0
  #raise TriangleError, "Sides must by numbers greater than zero" if (a <= 0) || (b <= 0) || (c <= 0)
  #raise TriangleError, "No two sides can add to be less than or equal to the other side" if (a+b <= c) || (a+c <= b) || (b+c <= a)
end
  
      

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end

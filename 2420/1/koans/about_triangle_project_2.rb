require File.expand_path(File.dirname(__FILE__) + '/neo')

require './triangle.rb'

# Let's handle that part now.
class AboutTriangleProject2 < Neo::Koan 
  def test_illegal_triangles_throw_exceptions
    assert_raise(TriangleError) { triangle(0, 0, 0) }
    assert_raise(TriangleError) { triangle(3, 4, -5) }
    assert_raise(TriangleError) { triangle(1, 1, 3) }
    assert_raise(TriangleError) { triangle(2, 4, 2) }
    # HINT: for tips, see http://stackoverflow.com/questions/3834203/ruby-koan-151-raising-exceptions
  end
end
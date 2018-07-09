require File.expand_path(File.dirname(__FILE__) + '/neo')

# You need to write the triangle method in the file 'triangle.rb'
require './triangle.rb'

# asdf asdf asdf
class AboutTriangleProjectSec < Neo::Koan
  # The first assignment did not talk about how to handle errors.
  # Let's handle that part now.
  # :reek:DuplicateMethodCall
  # :reek:TooManyStatements
  def test_illegal_triangles_throw_exceptions
    assert_raise(TriangleError) { triangle(0, 0, 0) }
    assert_raise(TriangleError) { triangle(3, 4, -5) }
    assert_raise(TriangleError) { triangle(1, 1, 3) }
    assert_raise(TriangleError) { triangle(2, 4, 2) }
  end
end

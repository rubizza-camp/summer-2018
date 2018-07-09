# frozen_string_literal: true
# rubocop:disable Metrics/AbcSize

# rubocop:disable Metrics/LineLength
# rubocop:disable Layout/Tab
# rubocop:disable Metrics/MethodLength
# rubocop:disable Layout/IndentationWidth
# :reek:FeatureEnvy
# :reek:TooManyStatements
def triangle(sid_a, side_b, side_c)
	sides = [sid_a, side_b, side_c].sort
	raise TriangleError, "triangle should't have a negative side " if sides.any? { |side| side <= 0 }
	raise TriangleError, 'wrong triangle' unless (sides[0] + sides[1]) > sides[2]
	sides.uniq!

	if sides.count == 1
			:equilateral
	elsif sides.count == 2
			:isosceles
	else
			:scalene
	end
end
# rubocop:enable Metrics/LineLength
# rubocop:enable Metrics/AbcSize
# rubocop:enable Layout/Tab
# rubocop:enable Metrics/MethodLength
# rubocop:enable Layout/IndentationWidth

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end

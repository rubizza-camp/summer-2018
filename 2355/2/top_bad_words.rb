require './find_obscenity.rb'

# rubocop:disable Metrics/LineLength
# rubocop:disable Metrics/AbcSize
# rubocop:disable Layout/CommentIndentation
# rubocop:disable Layout/IndentationWidth
# rubocop:disable Layout/DefEndAlignment
# rubocop:disable Layout/IndentationConsistency
# rubocop:disable Layout/Tab
# rubocop:disable Style/UnneededInterpolation
# This class is needed for first level of Task 2
# This class smells of :reek:Attribute
class TopBad
	attr_accessor :battlers, :top_obscenity

	def initialize
		@battlers = []
		@top_obscenity = {}
	end

	def set_battlers_names
		file = File.new('./battlers')
		file.each { |line| @battlers << line.delete("\n") }
	end

	# This method smells of :reek:DuplicateMethodCall
  def set_top_obscenity
		0.upto(battlers.size - 1) do |indexx|
			check = FindObscenity.new(@battlers[indexx])
			check.check_battles_for_obscenity
			top_obscenity["#{@battlers[indexx]}"] = check.obscenity.size
		end
	end

	# This method smells of :reek:DuplicateMethodCall
  # This method smells of :reek:NestedIterators
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:UtilityFunction
  def average_words_in_round(battler)
		counter = 0
		1.upto(Dir[File.join("./rap-battles/#{battler}/", '**', '*')].count { |file| File.file?(file) }) do |indexx|
			file = File.new("./rap-battles/#{battler}/#{indexx}")
			file.each do |line|
				mass = line.split
				mass.each { counter += 1 }
			end
		end
		counter / ((Dir[File.join("./rap-battles/#{battler}/", '**', '*')].count { |file| File.file?(file) }) * 3)
	end

	def average_bad_words_in_battle(battler)
		top_obscenity["#{battler}"] / (Dir[File.join("./rap-battles/#{battler}/", '**', '*')].count { |file| File.file?(file) })
	end
end
# rubocop:enable Metrics/LineLength
# rubocop:enable Metrics/AbcSize
# rubocop:enable Layout/CommentIndentation
# rubocop:enable Layout/IndentationWidth
# rubocop:enable Layout/DefEndAlignment
# rubocop:enable Layout/IndentationConsistency
# rubocop:enable Layout/Tab
# rubocop:enable Style/UnneededInterpolation

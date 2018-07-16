require 'russian_obscenity'

# rubocop:disable Metrics/MethodLength
# rubocop:disable Metrics/AbcSize
# rubocop:disable Style/IfUnlessModifier
# rubocop:disable Layout/DefEndAlignment
# rubocop:disable Layout/Tab
# rubocop:disable Layout/IndentationWidth
# rubocop:disable Layout/IndentationConsistency
# rubocop:disable Layout/CommentIndentation
# rubocop:disable Lint/ImplicitStringConcatenation
# rubocop:disable Performance/RedundantMatch
# This class is needed to find and collect all obscenity from text files
# This class smells of :reek:Attribute
# This class smells of :reek:InstanceVariableAssumption
class FindObscenity
	attr_accessor :obscenity

	def initialize(battler)
		@battler = battler
	end

	def initialize_mistakes
		@mistakes = []
		file = File.new('./mistakes')
		file.each { |line| @mistakes << line.delete("\n") }
	end

	# This method smells of :reek:DuplicateMethodCall
  # This method smells of :reek:NestedIterators
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:UncommunicativeVariableName
  def check_battles_for_obscenity
		initialize_mistakes
		@obscenity = []
		1.upto(Dir[File.join("./rap-battles/#{@battler}/", '**', '*')].count { |file| File.file?(file) }) do |i|
			file = File.new("./rap-battles/#{@battler}/#{i}")
			file.each do |line|
				mass = line.split
				mass.each do |word|
					if word.match(/.*\*.*[А-Яа-я.,]$/)
						word = word.delete '.' ',' '?»' '&quot' '!' ';'
						@obscenity << word
					end
				end
				rus_obs = RussianObscenity.find(line)
				rus_obs.each do |word|
					@mistakes.each do |mis|
						if mis.casecmp(word)
							rus_obs.delete(word)
						end
					end
				end
				rus_obs.each { |word| @obscenity << word }
			end
		end
	end
end
# rubocop:enable Metrics/MethodLength
# rubocop:enable Metrics/AbcSize
# rubocop:enable Style/IfUnlessModifier
# rubocop:enable Layout/DefEndAlignment
# rubocop:enable Layout/Tab
# rubocop:enable Layout/IndentationWidth
# rubocop:enable Layout/IndentationConsistency
# rubocop:enable Layout/CommentIndentation
# rubocop:enable Lint/ImplicitStringConcatenation
# rubocop:enable Performance/RedundantMatch

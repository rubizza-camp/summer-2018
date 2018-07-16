# rubocop:disable Metrics/AbcSize
# rubocop:disable Metrics/MethodLength
# rubocop:disable Style/UnneededInterpolation
# rubocop:disable Style/IfUnlessModifier
# rubocop:disable Style/NegatedWhile
# rubocop:disable Lint/UnusedBlockArgument
# rubocop:disable Lint/ImplicitStringConcatenation
# rubocop:disable Layout/IndentationConsistency
# rubocop:disable Layout/IndentationWidth
# rubocop:disable Layout/EndAlignment
# rubocop:disable Layout/DefEndAlignment
# rubocop:disable Layout/Tab
# This class is needed to find most popular words from text files
# This class smells of :reek:Attribute
class TopWord
	attr_accessor :battler

	def initialize(battler)
		@battler = battler
		@words = []
    @top_words = {}
	end

	# This method smells of :reek:NestedIterators
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:UncommunicativeVariableName
  def check_all_words
		1.upto(Dir[File.join("./rap-battles/#{@battler}/", '**', '*')].count { |file| File.file?(file) }) do |i|
			file = File.new("./rap-battles/#{@battler}/#{i}")
			file.each do |line|
				mass = line.split
				mass.each do |word|
					word = word.delete '.' ',' '?»' '&quot' '!' ';'
					@words << word
				end
			end
		end
	end

  # This method smells of :reek:DuplicateMethodCall
  # This method smells of :reek:NilCheck
  # This method smells of :reek:TooManyStatements
  def top_words_counter
    mistakes = []
    file = File.new('./pretexts')
    file.each { |line| mistakes << line.delete("\n") }
    while !@words.empty?
      counter = 0
      @words.each do |word|
        if word == @words[0] && mistakes.index(word).nil?
          counter += 1
        end
      end
      @top_words["#{@words[0]}"] = counter
      @words.delete("#{@words[0]}")
   end
  end

  # This method smells of :reek:DuplicateMethodCall
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:UncommunicativeVariableName
  def res(value)
    res = []
    @top_words = @top_words.sort_by { |key, val| val }
    @top_words = @top_words.reverse
    0.upto(value - 1) { |i| res << @top_words[i] }
    res.size.times { |i| puts "#{res[i][0]}" + ' - ' + "#{res[i][1]}" + ' раз(а)' }
  end
end
# rubocop:enable Metrics/AbcSize
# rubocop:enable Metrics/MethodLength
# rubocop:enable Style/UnneededInterpolation
# rubocop:enable Style/IfUnlessModifier
# rubocop:enable Style/NegatedWhile
# rubocop:enable Lint/UnusedBlockArgument
# rubocop:enable Lint/ImplicitStringConcatenation
# rubocop:enable Layout/IndentationConsistency
# rubocop:enable Layout/IndentationWidth
# rubocop:enable Layout/EndAlignment
# rubocop:enable Layout/DefEndAlignment
# rubocop:enable Layout/Tab

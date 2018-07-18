require './find_obscenity.rb'

# This class is needed for first level of Task 2
class TopBad
  attr_reader :battlers, :top_obscenity

  def initialize
    @battlers = []
    @top_obscenity = {}
  end

  def set_battlers_names
    file = File.new('./battlers')
    file.each { |line| @battlers << line.delete("\n") }
  end

  # This method smells of :reek:UtilityFunction
  def dir_count(battler)
    Dir[File.join("./rap-battles/#{battler}/", '**', '*')].count { |file| File.file?(file) }
  end

  # This method smells of :reek:DuplicateMethodCall
  def set_top_obscenity
    0.upto(battlers.size - 1) do |index|
      check = FindObscenity.new(@battlers[index])
      check.check_battles_for_obscenity
      top_obscenity[@battlers[index]] = check.obscenity.size
    end
  end

  # This method smells of :reek:DuplicateMethodCall
  # This method smells of :reek:NestedIterators
  def average_words_in_round(battler, counter = 0)
    1.upto(dir_count(battler)) do |text|
      File.new("./rap-battles/#{battler}/#{text}").each do |line|
        line.split.each { counter += 1 }
      end
    end
    counter / (dir_count(battler) * 3)
  end

  def average_bad_words_in_battle(battler)
    top_obscenity[battler] / dir_count(battler)
  end
end

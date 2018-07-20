require './find_obscenity.rb'

# This class is needed for first level of Task 2
class TopBad
  attr_reader :battlers, :top_obscenity

  def initialize
    @battlers = []
    @top_obscenity = {}
    @dir_count = 0
    @words_count = 0
  end

  def battlers_names
    file = File.new('./battlers')
    file.each { |line| @battlers << line.delete("\n") }
  end

  def dir_count(battler)
    @dir_count = Dir[File.join("./rap-battles/#{battler}/", '**', '*')].count { |file| File.file?(file) }
  end

  def top_obscenity_check
    0.upto(battlers.size - 1) do |index|
      name = @battlers[index]
      check = Obscenity.new(name)
      check.check_battles_for_obscenity
      top_obscenity[name] = check.obscenity.size
    end
  end

  def words_in_text(battler, text)
    File.new("./rap-battles/#{battler}/#{text}").each do |line|
      line.split.each { @words_count += 1 }
    end
  end

  def average_words_in_round(battler)
    @words_count = 0
    dir_count(battler)
    1.upto(@dir_count) do |text|
      words_in_text(battler, text)
    end
    @words_count / (@dir_count * 3)
  end

  def average_bad_words_in_battle(battler)
    dir_count(battler)
    top_obscenity[battler] / @dir_count
  end
end

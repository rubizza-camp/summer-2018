require 'russian_obscenity'

# This class is needed to find and collect all obscenity from text files
class FindObscenity
  attr_reader :obscenity

  def initialize(battler)
    @battler = battler
    @mistakes = []
    @obscenity = []
  end

  def dir_count
    Dir[File.join("./rap-battles/#{@battler}/", '**', '*')].count { |file| File.file?(file) }
  end

  def initialize_mistakes
    File.new('./mistakes').each { |line| @mistakes << line.delete("\n") }
  end

  # This method smells of :reek:NestedIterators
  def first_check
    1.upto(dir_count) do |text|
      File.new("./rap-battles/#{@battler}/#{text}").each do |line|
        line.split.each do |word|
          if word =~ /.*\*.*[А-Яа-я.,]$/
            word = word.delete '.', ',', '?»', '&quot', '!', ';'
            @obscenity << word
          end
        end
      end
    end
  end

  # This method smells of :reek:NestedIterators
  def check_rus_obs
    1.upto(dir_count) do |text|
      File.new("./rap-battles/#{@battler}/#{text}").each do |line|
        RussianObscenity.find(line).each do |word|
          @mistakes.each { |mis| @obscenity << word unless mis.casecmp(word) }
        end
      end
    end
  end

  def check_battles_for_obscenity
    initialize_mistakes
    first_check
    check_rus_obs
  end
end

require 'russian_obscenity'

# This class is needed to find and collect all obscenity from text files
class Obscenity
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

  # In methods first_check and check_rus_obs I use disabling reek:NestedIterators,
  # because I believe that this method of implementing the search for specific words
  # in a large text is the most acceptable.
  # I would have each block do-end to make a separate function and call them all one by one,
  # but in my opinion, this will lower the readability of the code.
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
